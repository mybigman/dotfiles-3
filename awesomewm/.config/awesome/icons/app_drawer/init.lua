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
  "images",
  "hydra",
  "wpscrack",
  "wpscan",
  "wireshark",
  "wifite",
  "weechat",
  "irc-chat",
  "videogames",
  "dontstarve",
  "signal",
  "reddit",
  "reaver",
  "nmap",
  "nikto",
  "lutris",
  "sound",
  "feh",
  "exploit-db",
  "mail",
  "mpd"
}

for _,v in pairs(icon_name) do
  icons[v] = p..v..".svg"
end

return icons
