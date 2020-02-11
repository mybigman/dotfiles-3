local p = os.getenv("HOME") .. "/.config/awesome/icons/app_drawer/"
local icons = {}
local icon_name = {
  "terminal",
  "gimp",
  "twitter",
  "github",
  "reddit",
  "virtualbox",
  "tilix",
  "steam",
  "ruby",
  "neovim",
  "mpv",
  "imagemagick",
  "github",
  "youtube",
  "brave",
  "images"
}

for _,v in pairs(icon_name) do
  icons[v] = p..v..".svg"
end

return icons
