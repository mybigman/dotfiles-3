local env = {}

env.term = os.getenv("TERMINAL") or "xterm"
env.editor = os.getenv("EDITOR") or "vim"

-- Bellow are arguments to call a <class> and <exec> a program by terminal
-- st or xst
env.term_call = { " -c ", " -e " }
-- kitty, env.term_call = { " --class=" , " -e " }
-- rxvt or urxvt, env.term_call = { " -T ", " -e " }

env.editor_cmd = env.term .. env.term_call[2] .. env.editor

return env
