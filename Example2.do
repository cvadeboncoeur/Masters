
* Example 2
* Logistic model for CHD as a function of a continuous age variable and dichotomous indicators for gender and for <12 years of education (“lowed”)


*Creation of a new variable, lowed and definining the parameters of the variable
*Attributes ">=12 years  and  <12 years to the label created in the previous step
recode educ (2/3=0) (1=1), gen(lowed)
label define lowed 0">=12 years" 1 "<12 years"

*Assigning the label to the new variable generated
label values lowed lowed

*renaming the variable
label variable lowed "Low education"
tab lowed

*centering the values around the mean
sum age
gen age_c=age-r(mean)

*logistic regression where  CHD is the outcome with variables of age as continuous, gender and lowed as dichotomous
sum age_c
logit chd age_c  i.gender i.lowed, nolog

*obtaining the odds ratios for an exposure to age of 10 units
lincom age_c*10, or

*obtaining the odds ratios for an exposure to age of 10 units and to low education
lincom age_c*10 +1.lowed, or

*Calculating the Hosmer-Lemeshow goodness-of-fit statistic
lfit, group(10) table

*calculating the standardized Pearson residuals
predict spearson, rstandard
sum spearson, detail

*graph of the residuals against age 
twoway (scatter spearson age), title("Standardized Pearson residuals by age at interview") xtitle("age at interview")

*Evaluate whether the assumption that the logit of risk for “chd,” conditional on low education and gender, is linear in age, using the following categories of exposure: 25 to 34 yrs (reference category), 35 to 44 yrs, 45 to 54 yrs, 55 to 64 yrs, and 65-74 yrs. 
*Creation of a new age variable with different categories
egen agecat3=cut(age) if age!=., at (24 35 45 55 65 75) icodes

*obtaining the coefficients for alpha and the betas of gender, lowed and different categories of age when looking at the CHD outcome
logit chd i.agecat3 i.gender i.lowed, nolog

*obtaining the different  ORs to assess if it is a monotonic dose-response
logit chd i.agecat3 i.gender i.lowed, or

*Fiting a logistic model for CHD using age as a categorical variable (as above), “gender”, “lowed”, and new dummy variable for exposure to exactly 12 years of education
logit chd i.agecat3 i.gender i.lowed i.twelveY, nolog

*likelihood ratio test to determine whether the dummy variable for exactly 12 years of education should be retained in the model
logit chd i.agecat3 gender lowed twelveY, nolog
estimates store A 
logit chd i.agecat3 gender lowed, nolog
estimates store B
lrtest B A
Likelihood-ratio test   
