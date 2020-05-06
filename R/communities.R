
#'@title Calculate the shallow community value for a given light level
#'@description This function captures the preferred light environment of the "shallow" coral community.
#'@details A Michaelis-Menten equation is used to represent the relationship between shallow coral
#'communities and light. We assume shallow corals are light-limited beneath a light threshold, and that community
#'values (how similar a reef patch is to the idealised shallow community) increase asymptotically with increasing light.
#'
#'This relationship has been verified in the Red Sea (Tamir et al., 2019), but certainly needs more research!
#'@param light The percentage of surface irradiance (PAR) reaching a reef, positive and up to 100\%.
#'@param Vm The maximum similarity of a reef patch to the idealised shallow reef community, between 0 and 1.
#'Defaults to (Tamir et al., 2019).
#'@param K The light value where the community value = Vmax/2, between 0 and 100. Defaults to (Tamir et al., 2019).
#'This can be interpreted as the light level at which shallow reef communities become light limited.
#'@return A shallow community indicator value, as discussed in (Laverick et al., 2017). When a single light value is
#'provided, a single value is returned. You can pass a vector of light levels for a vector of depths.
#'@examples
#'# Specifying a single light value
#'# returns a single community value.
#'
#'    shallow(light = 10)
#'
#'
#'# Specifying a vector of light values
#'# returns a vector of community values.
#'
#'    shallow(light = seq(0.0065, 100, length = 500))
#'
#'
#'# By default the function uses the shallow community
#'# light relationship from (Tamir et al., 2019) for a
#'# range of light values.
#'
#'    shallow()
#'
#'
#'# You can specify your own community light relationship
#'# by setting parameters explicitly
#'
#'    shallow(Vm = 0.2, K = 11)
#'
#'
#'@family Community relationships
#'@references (Tamir et al., 2019)
#'
#'(Laverick et al., 2017)
#'@export
shallow <- function (light = seq(0.0001, 1, length = 500), Vm = 0.393, K = 13.5) {
  Shallow <- Vm * (light*100)/(K+(light*100))
  return(Shallow)
}

#'@title Calculate the mesophotic community value for a given light level
#'@description This function captures the preferred light environment of the mesophotic coral community.
#'@details A Weibull distribution is used to represent the relationship between mesophotic coral communities
#'and light. We assume mesophotic community values (how similar a reef patch is to the idealised mesophotic
#'community) center on a preferred light value, between light limitation and light-induced stress.
#'
#'This relationship has been verified in the Red Sea (Tamir et al., 2019), but certainly needs more research!
#'@param light The percentage of surface irradiance (PAR) reaching a reef, positive and up to 100\%.
#'@param a The scale parameter of a Weibull distribution, defaults to (Tamir et al., 2019).
#' a describes the spread of the data, or ‘the peakyness’. Larger numbers create a flatter, wider, curve.
#' Varying a will simultaneously change the width of the preferred light environment of mesophotic taxa,
#' and the maximum similarity a reef patch is expected to achieve in comparison to the idealised mesophotic community.
#'@param b The shape parameter of a Weibull distribution, defaults to (Tamir et al., 2019). A value of 3
#'approximates a normal distribution. Values larger than 3 introduce a left-skew to the curve. This means
#'mesophotic taxa can be light-limited, while keeping mesophotic communities in low-light environments.
#'Varying b shifts the preferred light environment of mesophotic communities.
#'@return A mesophotic community indicator value, as discussed in (Laverick et al., 2017). When a single light value is
#'provided, a single value is returned. You can pass a vector of light levels for a vector of depths.
#'@examples
#'# Specifying a single light value
#'# returns a single community value.
#'
#'    mesophotic(light = 10)
#'
#'
#'# Specifying a vector of light values
#'# returns a vector of community values.
#'
#'    mesophotic(light = seq(0.0065, 100, length = 500))
#'
#'
#'# By default the function uses the shallow community
#'# light relationship from (Tamir et al., 2019) for a
#'# range of light values.
#'
#'    mesophotic()
#'
#'
#'# You can specify your own community light relationship
#'# by setting parameters explicitly
#'
#'    mesophotic(a = 1.2, b = 8)
#'
#'
#'@family Community relationships
#'@references (Tamir et al., 2019)
#'
#'(Laverick et al., 2017)
#'@export
mesophotic <- function (light = seq(0.0001, 1, length = 500), a = 1.54, b = 8.92) {
  Mesophotic <- (a/b)*((light*100)/b)^(a-1)*exp(-((light*100)/b)^a)
  return(Mesophotic)
}
