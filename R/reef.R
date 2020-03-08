
#'@title Calculate the whole-reef community value for a given light level
#'@description This function returns the community value for the whole reef community at a light level, given shallow
#'and mesophotic community light relationships.
#'@details The function assumes a tradeoff, where an observed patch of reef can approach a mesophotic or
#'shallow community. A patch of reef cannot simultaneously look like the exemplar mesophotic and shallow reef patch.
#'This is achieved by subtracting the shallow community value from the mesophotic community value.
#'
#'Essentially this function is a wrapper for mesophotic() - shallow(), but it is neccessary for use in
#'\code{\link{boundary}} when calculating the light level the communities switch at.
#'@param light The proportion of surface irradiance (PAR), between 0 and 1.
#'@param Vm Passed to \code{\link{shallow}}. The maximum similarity of a reef patch to the idealised shallow reef
#'community, between 0 and 1. Defaults to (Tamir et al., 2019).
#'@param K Passed to \code{\link{shallow}}. The light value where the community value = Vmax/2, between 0 and 100.
#'Defaults to (Tamir et al., 2019). This can be interpreted as the light level at which shallow reef communities
#'become light limited.
#'@param a Passed to \code{\link{mesophotic}}. The scale parameter of a Weibull distribution, defaults to (Tamir et
#'al., 2019). a describes the spread of the data, or ‘the peakyness’. Larger numbers create a flatter, wider, curve.
#'Varying a will simultaneously change the width of the preferred light environment of mesophotic taxa,
#'and the maximum similarity a reef patch is expected to achieve in comparison to the idealised mesophotic community.
#'@param b Passed to \code{\link{mesophotic}}. The shape parameter of a Weibull distribution, defaults to (Tamir et
#'al., 2019). A value of 3 approximates a normal distribution. Values larger than 3 introduce a left-skew to the curve.
#'This means mesophotic taxa can be light-limited, while keeping mesophotic communities in low-light environments.
#'Varying b shifts the preferred light environment of mesophotic communities.
#'@return A reef wide community indicator value. This is the basis of the model presented in (Laverick et al., 2020).
#'When a single light value is provided, a single value is returned. You can pass a vector of light levels for a vector of depths.
#'@examples
#'# Specifying a single light value
#'# returns a single community value.
#'
#'    reef(light = 10)
#'
#'
#'# Specifying a vector of light values
#'# returns a vector of community values.
#'
#'    reef(light = seq(0.0065, 1, length = 500))
#'
#'
#'# By default the function uses the shallow and mesophotic
#'# community light relationships from (Tamir et al., 2019)
#'# for a range of light values.
#'
#'    reef()
#'
#'
#'# You can specify your own community light relationships
#'# by setting parameters explicitly
#'
#'    reef(Vm = 0.2, K = 11, a = 1.2, b = 8)
#'
#'
#'@seealso \code{\link{shallow}}
#'
#'\code{\link{mesophotic}}
#'
#'\code{\link{boundary}}
#'@references (Tamir et al., 2019)
#'
#'(Laverick et al., 2020)
#'@export
reef <- function(light = seq(0.0065, 1, length = 500), Vm = 0.393, K = 13.5, a = 1.54, b = 8.92) {
  reef <- mesophotic(light*100, a = a, b = b) - (shallow(light*100, Vm = Vm, K = K))
  return(reef)
  #1 - 0.25 (No shading, to shading from a vertical wall (Lesser et al., 2018))
}

#'@title Calculate the light level where a coral reef switches from shallow to mesophotic
#'@description This function finds the light level where the shallow and mesophotic community values are equal.
#'@details When the community values are equal for shallow and mesophotic communities, given a light level, a
#'reef looks equally similar to a shallow or mesophotic reef. Changing the light level will tip the reef towards
#'either a shallow or mesophotic community.
#'
#'Strictly, this function finds the mathematical root of \code{\link{reef}}, searching between light levels of 0.01
#'and 100 percent of surface Photosynthetically Active Radiation (PAR).
#'
#'\code{\link{depth}} can then be used to convert the boundary light level to boundry depths under different
#'environmental conditions.
#'@param Vm Passed to \code{\link{shallow}}. The maximum similarity of a reef patch to the idealised shallow reef
#'community, between 0 and 1. Defaults to (Tamir et al., 2019).
#'@param K Passed to \code{\link{shallow}}. The light value where the community value = Vmax/2, between 0 and 100.
#'Defaults to (Tamir et al., 2019). This can be interpreted as the light level at which shallow reef communities
#'become light limited.
#'@param a Passed to \code{\link{mesophotic}}. The scale parameter of a Weibull distribution, defaults to (Tamir et
#'al., 2019). a describes the spread of the data, or ‘the peakyness’. Larger numbers create a flatter, wider, curve.
#'Varying a will simultaneously change the width of the preferred light environment of mesophotic taxa,
#'and the maximum similarity a reef patch is expected to achieve in comparison to the idealised mesophotic community.
#'@param b Passed to \code{\link{mesophotic}}. The shape parameter of a Weibull distribution, defaults to (Tamir et
#'al., 2019). A value of 3 approximates a normal distribution. Values larger than 3 introduce a left-skew to the curve.
#'This means mesophotic taxa can be light-limited, while keeping mesophotic communities in low-light environments.
#'Varying b shifts the preferred light environment of mesophotic communities.
#'@return The light value when the shallow and mesophotic community values are equal.
#'@examples
#'# By default the function uses the shallow and mesophotic
#'# community light relationships from (Tamir et al., 2019).
#'
#'    boundary()
#'
#'
#'# You can specify your own community light relationships
#'# by setting parameters explicitly
#'
#'    boundary(Vm = 0.2, K = 11, a = 1.2, b = 8)
#'
#'
#'@seealso \code{\link{reef}}
#'
#'\code{\link{depth}}
#'@references (Tamir et al., 2019)
#'
#'(Laverick et al., 2020)
#'@export
boundary <- function(Vm = 0.393, K = 13.5, a = 1.54, b = 8.92) {
  root <- uniroot(reef, Vm=Vm, K=K, a=a, b=b, interval= c(0.01, 100), tol= 0.000001)$root
  return(root)
}
