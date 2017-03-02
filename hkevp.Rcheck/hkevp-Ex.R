pkgname <- "hkevp"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('hkevp')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
cleanEx()
nameEx("extrapol.gev")
### * extrapol.gev

flush(stderr()); flush(stdout())

### Name: extrapol.gev
### Title: Spatial extrapolation of GEV parameters with the HKEVP
### Aliases: extrapol.gev

### ** Examples

# Simulation of HKEVP:
sites <- as.matrix(expand.grid(1:3,1:3))
loc <- sites[,1]*10
scale <- 3
shape <- 0
alpha <- .4
tau <- 1
ysim <- hkevp.rand(10, sites, sites, loc, scale, shape, alpha, tau)

# HKEVP fit:
fit <- hkevp.fit(ysim, sites, niter = 1000)

## Extrapolation:
targets <- matrix(1.5, 1, 2)
gev.targets <- extrapol.gev(fit, targets)

## True vs predicted:
predicted <- sapply(gev.targets, median)
sd.predict <- sapply(gev.targets, sd)
true <- c(targets[,1]*10, scale, shape)
# cbind(true, predicted, sd.predict)





cleanEx()
nameEx("extrapol.return.level")
### * extrapol.return.level

flush(stderr()); flush(stdout())

### Name: extrapol.return.level
### Title: Spatial extrapolation of a return level.
### Aliases: extrapol.return.level

### ** Examples

# Simulation of HKEVP:
sites <- as.matrix(expand.grid(1:3,1:3))
knots <- sites
loc <- sites[,1]*10
scale <- 1
shape <- .2
alpha <- .4
tau <- 1
ysim <- hkevp.rand(10, sites, knots, loc, scale, shape, alpha, tau)

# HKEVP fit:
fit <- hkevp.fit(ysim, sites, niter = 1000)

## Extrapolation of the 100-years return level (may need more iterations and burn-in/nthin):
targets <- as.matrix(expand.grid(1.5:2.5,1.5:2.5))
pred.sample <- extrapol.return.level(100, fit, targets)
pred.mean <- apply(pred.sample, 2, mean)
pred.sd <- apply(pred.sample, 2, sd)
true <- return.level(100, targets[,1]*10, scale, shape)
# cbind(true, pred.mean, pred.sd)






cleanEx()
nameEx("hkevp.expmeasure")
### * hkevp.expmeasure

flush(stderr()); flush(stdout())

### Name: hkevp.expmeasure
### Title: Exponent measure of the HKEVP
### Aliases: hkevp.expmeasure

### ** Examples

sites <- as.matrix(expand.grid(1:3,1:3))
loc <- sites[,1]*10
scale <- 3
shape <- 0
alpha <- .4
tau <- 1
ysim <- hkevp.rand(10, sites, sites, loc, scale, shape, alpha, tau)

# HKEVP fit:
fit <- hkevp.fit(ysim, sites, niter = 1000)

predict.em <- hkevp.expmeasure(1, fit = fit)
true.em <- hkevp.expmeasure(1, sites, sites, alpha, tau)
# plot(predict.em, ylim = range(predict.em, true.em), type = "l")
# abline(h = true.em, col = 2, lwd = 2)





cleanEx()
nameEx("hkevp.fit")
### * hkevp.fit

flush(stderr()); flush(stdout())

### Name: hkevp.fit
### Title: Fitting procedure of the HKEVP with MCMC algorithm
### Aliases: hkevp.fit

### ** Examples

# Simulation of HKEVP:
set.seed(1)
sites <- as.matrix(expand.grid(1:3,1:3))
loc <- sites[,1]*10
scale <- 3
shape <- 0
alpha <- .4
tau <- 1
ysim <- hkevp.rand(10, sites, sites, loc, scale, shape, alpha, tau)

# HKEVP fit:
fit <- latent.fit(ysim, sites, niter = 1000)






cleanEx()
nameEx("hkevp.predict")
### * hkevp.predict

flush(stderr()); flush(stdout())

### Name: hkevp.predict
### Title: Predictive distribution of the max-stable process at target
###   positions.
### Aliases: hkevp.predict

### ** Examples

# Simulation of HKEVP:
sites <- as.matrix(expand.grid(1:3,1:3))
targets <- as.matrix(expand.grid(1.5:2.5,1.5:2.5))
all.pos <- rbind(sites, targets)
knots <- sites
loc <- all.pos[,1]*10
scale <- 3
shape <- 0
alpha <- .4
tau <- 1
ysim <- hkevp.rand(10, all.pos, knots, loc, scale, shape, alpha, tau)
yobs <- ysim[,1:9]

# HKEVP fit (omitting first site, used as target):
fit <- hkevp.fit(yobs, sites, niter = 1000)

# Extrapolation:
ypred <- hkevp.predict(fit, targets, predict.type = "kriging")

# Plot of the density and the true value for 4 first realizations:
# par(mfrow = c(2, 2))
# plot(density(ypred[1,1,]), main = "Target 1 / Year 1")
# abline(v = ysim[1,10], col = 2, lwd = 2)
# plot(density(ypred[2,1,]), main = "Target 1 / Year 2")
# abline(v = ysim[2,10], col = 2, lwd = 2)
# plot(density(ypred[1,2,]), main = "Target 2 / Year 1")
# abline(v = ysim[1,11], col = 2, lwd = 2)
# plot(density(ypred[2,2,]), main = "Target 2 / Year 2")
# abline(v = ysim[2,11], col = 2, lwd = 2)







cleanEx()
nameEx("hkevp.rand")
### * hkevp.rand

flush(stderr()); flush(stdout())

### Name: hkevp.rand
### Title: Simulation of the HKEVP
### Aliases: hkevp.rand

### ** Examples

# Simulation of HKEVP:
sites <- as.matrix(expand.grid(1:3,1:3))
loc <- sites[,1]*10
scale <- 3
shape <- 0
alpha <- .4
tau <- 1
ysim <- hkevp.rand(10, sites, sites, loc, scale, shape, alpha, tau)








cleanEx()
nameEx("latent.fit")
### * latent.fit

flush(stderr()); flush(stdout())

### Name: latent.fit
### Title: Fitting procedure of the latent variable model
### Aliases: latent.fit

### ** Examples

# Simulation of HKEVP:
sites <- as.matrix(expand.grid(1:4,1:4))
loc <- sites[,1]*10
scale <- 3
shape <- .2
alpha <- 1
tau <- 2
ysim <- hkevp.rand(15, sites, sites, loc, scale, shape, alpha, tau)

# Latent Variable Model fit:
set.seed(1)
fit <- latent.fit(ysim, sites, niter = 10000, nburn = 5000, nthin = 5)



mcmc.plot(fit, TRUE)
par(mfrow = c(2,2))
apply(fit$GEV[,1,], 1, acf)








graphics::par(get("par.postscript", pos = 'CheckExEnv'))
cleanEx()
nameEx("mcmc.fun")
### * mcmc.fun

flush(stderr()); flush(stdout())

### Name: mcmc.fun
### Title: Point estimates of HKEVP fit
### Aliases: mcmc.fun

### ** Examples

# Simulation of HKEVP:
sites <- as.matrix(expand.grid(1:3,1:3))
knots <- sites
loc <- sites[,1]*10
scale <- 3
shape <- .2
alpha <- .4
tau <- 1
ysim <- hkevp.rand(10, sites, knots, loc, scale, shape, alpha, tau)

# HKEVP fit:
fit <- hkevp.fit(ysim, sites, niter = 1000)

# Posterior median and standard deviation:
# mcmc.fun(fit, median)
# mcmc.fun(fit, sd)






cleanEx()
nameEx("mcmc.plot")
### * mcmc.plot

flush(stderr()); flush(stdout())

### Name: mcmc.plot
### Title: Markov chains plotting
### Aliases: mcmc.plot

### ** Examples

# Simulation of HKEVP:
sites <- as.matrix(expand.grid(1:3,1:3))
knots <- sites
loc <- sites[,1]*10
scale <- 3
shape <- .2
alpha <- .4
tau <- 1
ysim <- hkevp.rand(10, sites, knots, loc, scale, shape, alpha, tau)

# HKEVP fit:
fit <- hkevp.fit(ysim, sites, niter = 1000)

# Markov chains plot:
# mcmc.plot(fit)







cleanEx()
nameEx("return.level")
### * return.level

flush(stderr()); flush(stdout())

### Name: return.level
### Title: The associated return level
### Aliases: return.level

### ** Examples

return.level(period = 100, loc = 1, scale = 1, shape = 1)
return.level(period = 200, loc = 1:10, scale = 1, shape = 0)





### * <FOOTER>
###
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
