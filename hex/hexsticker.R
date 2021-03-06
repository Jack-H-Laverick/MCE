
library(hexSticker)
library(desc)

# sticker("polyp2.png", package="MCE", p_size=90, s_x=1.22, s_y= 0.77, s_width = 0.900, s_height = 0.540,
#         p_x = 0.85, h_fill = "darkslategray", h_color = "orange", filename="sticker1.png", dpi = 700,
#         url = "package@github.com", u_color = "white", u_size = 15)
#

# sticker("hex/polyp.png", package="MCE", p_size = 90, s_x=1.22, s_y= 0.77, s_width = 0.900,
#         s_height = 0.540, p_x = 0.85, h_fill = "#003366", h_color = "#CC6600", filename="hex/sticker.png",
#         dpi = 700, url = 'remotes::install_github("Jack-H-Laverick/MCE")', u_color = "white", u_size = 8)




desc = desc::description$new()
fig_dir = file.path("man", "figures")
if (dir.exists(fig_dir)) {
  dir.create(fig_dir, recursive = TRUE)
}
package = desc$get("Package")
hexSticker::sticker(
  "hex/polyp.png", package = package, p_size = 90, s_x=1.22, s_y= 0.77, s_width = 0.900,
  s_height = 0.540, p_x = 0.85, h_fill = "#003366", h_color = "#CC6600", dpi = 700,
  url = 'remotes::install_github("Jack-H-Laverick/MCE")', u_color = "white", u_size = 8,
  filename = file.path(fig_dir, "sticker.png"))

usethis::use_logo(file.path(fig_dir, "sticker.png"))
