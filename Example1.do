# Example 1
# Simple linear regression with fim as the dependent variable, and age, sex, and alcohol level. Including prediction for a male aged 50 with an alcohol level of 80
{
for (i in 1:60) {
mu.fim[i]  <- alpha + b.sex*sex[i] + b.age*age[i] + b.alcohol*alcohol[i]
fim[i]   ~ dnorm(mu.fim[i],tau)
}
alpha    ~ dnorm(0.0,1.0E-4)
b.sex    ~ dnorm(0.0,1.0E-4)
b.age    ~ dnorm(0.0,1.0E-4)
b.alcohol    ~ dnorm(0.0,1.0E-4)
tau     <-  1/(sigma*sigma)
sigma    ~  dunif(0,42)
pred.fim.male.30.85 <- alpha + b.sex*1 + b.age*30 + b.alcohol*85
pred.fim.female.50.0 <- alpha + b.sex*0 + b.age*50 + b.alcohol*0
diff <- pred.fim.male.30.85 - pred.fim.female.50.0
 }

}
# Data
sex[] age[] fim[] alcohol[]
( … ) # data not shown here but included in WinBUGS
END

# Inits
list(alpha=50, b.sex=1, b.age=4, b.alcohol=7)


#Investigating if the model fits well the data through a residuals
for(i in 1:60)
{
p[i] <- 1/60
}
choose ~ dcat(p[])
residual.mixture <- residual[choose]


