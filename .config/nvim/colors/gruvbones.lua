---@diagnostic disable: undefined-global

local colors_name = 'gruvbones'
vim.g.colors_name = colors_name

local lush = require 'lush'
local hsluv = lush.hsluv
local util = require 'zenbones.util'

local bg = vim.o.background

local palette
if bg == 'light' then
  palette = util.palette_extend({
    bg = hsluv '#fbf1c7',
    fg = hsluv '#3c3836',
    rose = hsluv '#9d0006',
    leaf = hsluv '#79740e',
    wood = hsluv '#b57614',
    water = hsluv '#076678',
    blossom = hsluv '#8f3f71',
    sky = hsluv '#427b58',
  }, bg)
else
  palette = util.palette_extend({
    bg = hsluv '#282828',
    fg = hsluv '#ebdbb2',
    rose = hsluv '#fb4934',
    leaf = hsluv '#b8bb26',
    wood = hsluv '#fabd2f',
    water = hsluv '#83a598',
    blossom = hsluv '#d3869b',
    sky = hsluv '#83c07c',
  }, bg)
end

local generator = require 'zenbones.specs'
local spec =
  generator.generate(palette, bg, generator.get_global_config(colors_name, bg))

spec = lush.extends({ spec }).with(function()
  return {
    CopilotSuggestion { spec.Comment, gui = 'bold' },
  }
end)

lush(spec)

require('zenbones.term').apply_colors(palette)
