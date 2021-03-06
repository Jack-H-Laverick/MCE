
#'@title Calculate the depth of a light level
#'@description This function uses the Lamberte-Beere law to predict the depth in metres a given proportion of surface
#'Photosynthetically Active Radiation (PAR) penetrates to.
#'@details The function takes the average light attenuation coefficient (KdPAR) of the water column above a reef and a
#' proportion between 0 and 1 of surface PAR. The Lamberte-Beer law is then used to predict the depth in metres this light
#' environment occurs at.
#'
#' A shading parameter can be used to scale how much of the light which reaches the seafloor is available to the benthos.
#' According to (Lesser et al., 2018) the shading effect of reef slope at a vertical wall is to limit surface irradiance to
#' 25\% (shade = 0.25). The default behaviour is for there to be no shading (Shade = 1).  When shading is more severe, the
#' function will return a shallower depth. This is as the function is predicting the depth you would find your specified light
#' level in the shaded environment.
#'
#' Leaving shade unspecified makes this function equivalent to the "Depth_function" in (Laverick et al. 2020).
#'
#' Specifying shading makes this function equivalent to the "Shade_function" in (Laverick et al., 2020).
#'@param light The proportion of surface irradiance (PAR), between 0 and 1. Defaults to a vector of light values.
#'@param KdPAR The average light attenuation coefficient of the water column  above the reef. Defaults to 0.05.
#'@param shade Additional shading at the seafloor, such as bathymetric effects, between 0 (no light available) and 1
#'(all light available). Defaults to 1 (all light available).
#'@return A depth in metres. When a single light value is provided, a single value is returned. You can pass a vector
#'of light levels for a vector of depths.
#'@family Environment functions
#'@examples
#'# Specifying a single light value and light
#'# attenuation returns a single depth.
#'
#'    depth(light = 0.1, KdPAR = 0.03)
#'
#'
#'# By defualt there is no shading. You can
#'# switch this on by passing a value.
#'
#'    depth(light = 0.1, KdPAR = 0.03, shade = 0.8)
#'
#'
#'# Specifying a vector of light values and light
#'# attenuation returns a vector of depths.
#'
#'    depth(light = seq(0.0065, 1, length = 500), KdPAR = 0.03)
#'
#'# By default the function uses the reference light
#'# environment from (Laverick et al., 2020) with no shade.
#'
#'    depth()
#'@references Lamberte-Beer law
#'
#'Lesser
#'
#'Laverick
#'@export
depth <- function (light = seq(0.01, 1, length = 500), KdPAR = 0.05, shade = 1) {
  Depth <- log(light/shade)/-KdPAR
  return(Depth)
}

