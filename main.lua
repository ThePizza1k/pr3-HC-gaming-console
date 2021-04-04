-- Console v1.4.1
player.fov = 0.115
player.speed = -49.9

if tolua(player.getmetadata("started", 0)) == 0 then
 local li = 0
 local lj = 0
 prgmpass = true

 player.setmetadata("started", 1)

 if settings_fpr == nil then
  settings_fpr = 5
 end
 if r_debug == nil then
  r_debug = false
 end
 if r_errexit == nil then
  r_errexit = false
 end
 
 local i = 0
 local j = 0
 local gbp = {}
 local b = block
 local bgb = tolua(b.getblock)
 local gb = {}

 local x,y
 for hcc = 0, 511 do
  x,y = 1 + 8*math.floor(hcc / 64) + hcc%8, 1 + math.floor((hcc%64) / 8)
  gb[hcc + 1] = bgb(x, y)
  gbp[hcc + 1] = {x, y}
 end

 local btp = {}
 for hcc in ipairs(gb) do
  btp[hcc] = tolua(gb[hcc].teleportto)
 end


 local r_pixels = {}
 local r_pixels_old = {}
 i = 1
 while i <= 71 do
  j = 1
  r_pixels[i] = {}
  r_pixels_old[i] = {}
  while j <= 45 do
   r_pixels[i][j] = 0
   r_pixels_old[i][j] = 0
   j = j + 1
  end
  i = i + 1
 end

  local tlib_textdef = {
    a = {{1,0,1,0,3},{0,1,0},{0,1,2},{1,2,1,2,3}},
    b = {{1,0,0,0,3},{1,1,0,1,1},{0,2,0},{0,2,2},{0,1,3}},
    c = {{1,0,1,0,2},{1,1,0,2,0},{1,1,3,2,3}},
    d = {{1,0,0,0,3},{1,2,1,2,2},{0,1,0},{0,1,3}},
    e = {{1,0,0,0,3},{1,1,0,2,0},{1,1,3,2,3},{0,1,1}},
    f = {{1,0,0,0,3},{1,1,0,2,0},{0,1,1}},
    g = {{1,0,1,0,2},{1,1,0,2,0},{1,1,3,2,3},{0,2,2}},
    h = {{1,0,0,0,3},{1,2,0,2,3},{0,1,1}},
    i = {{1,0,0,2,0},{1,0,3,2,3},{1,1,1,1,2}},
    j = {{1,0,0,2,0},{1,2,1,2,2},{0,0,2},{0,1,3}},
    k = {{1,0,0,0,3},{1,2,2,2,3},{0,2,0},{0,1,1}},
    l = {{1,0,0,0,3},{1,1,3,2,3}},
    m = {{1,0,0,0,3},{1,1,0,1,1},{1,2,0,2,3}},
    n = {{1,0,0,0,3},{1,2,1,2,3},{0,1,0}},
    o = {{1,0,1,0,2},{1,2,1,2,2},{0,1,0},{0,1,3}},
    p = {{1,0,0,0,3},{1,1,2,2,2},{1,1,0,2,0},{0,2,1}},
    q = {{1,0,1,0,2},{0,2,1},{0,1,0},{1,1,2,2,3}},
    r = {{1,0,0,0,3},{0,1,0},{0,1,2},{0,2,1},{0,2,3}},
    s = {{1,0,0,1,1},{1,0,3,2,3},{0,2,0},{0,2,2}},
    t = {{1,0,0,2,0},{1,1,1,1,3}},
    u = {{1,0,0,0,3},{1,2,0,2,3},{0,1,3}},
    v = {{1,0,0,0,2},{1,2,0,2,2},{0,1,3}},
    w = {{1,0,0,0,3},{1,2,0,2,3},{1,1,2,1,3}},
    x = {{1,0,2,0,3},{1,2,2,2,3},{0,2,0},{0,1,1},{0,0,0}},
    y = {{0,0,0},{0,2,0},{1,1,1,1,3}},
    z = {{1,0,0,2,0},{1,0,3,2,3},{0,1,1},{0,0,2}},
    ["1"] = {{1,0,0,1,0},{1,0,3,2,3},{1,1,1,1,2}},
    ["2"] = {{1,0,0,1,0},{1,0,3,2,3},{0,2,1},{0,1,2}},
    ["3"] = {{1,0,0,1,0},{1,0,3,1,3},{1,1,1,2,1},{0,2,2}},
    ["4"] = {{1,0,1,2,1},{1,2,2,2,3},{0,0,0},{0,2,0}},
    ["5"] = {{1,0,0,1,1},{1,0,3,1,3},{0,2,0},{0,2,2}},
    ["6"] = {{1,0,0,0,1},{1,1,0,2,0},{1,0,2,2,3}},
    ["7"] = {{1,0,0,2,0},{0,2,1},{0,1,2},{0,0,3}},
    ["8"] = {{1,0,0,2,1},{1,0,3,2,3},{0,0,2},{0,2,2}},
    ["9"] = {{1,2,2,2,3},{1,0,3,1,3},{1,0,0,2,1}},
    ["0"] = {{1,0,0,0,3},{1,2,0,2,3},{0,1,0},{0,1,3}},
    ["?"] = {{1,0,0,2,0},{0,2,1},{0,1,3}},
    ["!"] = {{1,0,0,0,1},{0,0,3}},
    ["."] = {{0,0,3}},
    [","] = {{1,0,2,0,3}},
    ["/"] = {{0,0,3},{0,2,0},{1,1,1,1,2}},
    ["-"] = {{1,0,2,2,2}},
    ["+"] = {{1,0,2,2,2},{0,1,1},{0,1,3}},
    ["*"] = {{0,0,1},{0,0,3},{0,1,2},{0,2,1},{0,2,3}},
    ["^"] = {{0,0,1},{0,1,0},{0,2,1}},
    ["'"] = {{0,1,0},{0,1,1}},
    ['"'] = {{1,0,0,0,1},{1,2,0,2,1}},
    ["="] = {{1,0,1,2,1},{1,0,3,2,3}},
    [":"] = {{0,1,0},{0,1,3}}
  }

  function hc_draw_text(string,xt,yt,color)
    local tlib_stringlength = string.len(string)
    local tlib_textx = xt
    local tlib_texty = yt
    for p=1,tlib_stringlength do
      if tlib_textx + 3 > 70 then
        tlib_textx = xt
        tlib_texty = tlib_texty + 5
      end
      if tlib_texty + 4 > 44 then
        break
      end
      local stringletter = string.sub(string,p,p)
      if stringletter == " " then
        tlib_textx = tlib_textx
      elseif stringletter == [[\]] then
        tlib_textx = xt-4
        tlib_texty = tlib_texty + 5
      else
        if tlib_textdef[stringletter] ~= nil then
          for var in pairs(tlib_textdef[stringletter]) do
            if tlib_texty < 0 then
              break
            end
            local txtdefletvar = tlib_textdef[stringletter][var]
            if txtdefletvar[1] == 1 then
              hc_draw_square((tlib_textx+txtdefletvar[2]),(tlib_texty+txtdefletvar[3]),(tlib_textx+txtdefletvar[4]),(tlib_texty+txtdefletvar[5]),color)
            else
              hc_draw_pixel((tlib_textx+txtdefletvar[2]),(tlib_texty+txtdefletvar[3]),color)
            end
          end
        else
          player.chat("invalid character! report this to whoever made the game you are playing.")
          hc_draw_square(tlib_textx,tlib_texty,(tlib_textx+2),(tlib_texty+3),7)
        end
      end
      tlib_textx = tlib_textx + 4
    end
  end

  function hc_readpixarr(x,y)
    return r_pixels[x+1][y+1]
  end

  function hc_takefullsnapshot()
    local return_table = {}
    for sn_i=1,71,1 do
      local column = r_pixels[sn_i]
      local rt_add = {}
      for sn_j=1,45,1 do
        rt_add[sn_j] = column[sn_j]
      end
      return_table[sn_i] = rt_add
    end
    return return_table
  end

  function hc_drawfullsnapshot(snp)
    for sn_i=1,71,1 do
      local snpcolumn = snp[sn_i]
      local pixcol = r_pixels[sn_i]
      for sn_j=1,45,1 do
        pixcol[sn_j] = snpcolumn[sn_j]
      end
    end
  end
 
  function hc_takesnapshot(x1,y1,x2,y2)
    local return_table = {}
    local x1 = x1 + 1
    local x2 = x2 + 1
    local y1 = y1 + 1
    local y2 = y2 + 1
    for sn_i=x1,x2,1 do
      local column = r_pixels[sn_i]
      local rt_add = {}
      for sn_j=y1,y2,1 do
        rt_add[sn_j] = column[sn_j]
      end
      return_table[sn_i] = rt_add
    end
    return return_table
  end

  function player_exit()
    player.removeitem()
    player.teleportto(0,18)
  end

  function player_finish()
    player.removeitem()
    player.teleportto(0,14)
  end

 r_frames = 0
 r_fpr = settings_fpr

 function display_pixel(x, y, color)
  btp[color](x - gbp[color][1], y - gbp[color][2], false, true)
 end
 function display_square(x1, y1, x2, y2, color)
  i = x1
  while i <= x2 do
   j = y1
   while j <= y2 do
    btp[color](i - gbp[color][1], j - gbp[color][2], false, true)
    j = j + 1
   end
   i = i + 1
  end
 end

 control_horizontal = 0
 control_up = 0

 function screen_refresh()
  local i = 1
  local j = 1
  local rpx = r_pixels
  local rpxo = r_pixels_old
  local rp
  local rpo
  while i <= 71 do
   j = 1
   rp = rpx[i]
   rpo = rpxo[i]
   while j <= 45 do
    if rp[j] ~= rpo[j] then
     display_pixel(i-36, j-49, rp[j]+1)
     rpxo[i][j] = rpx[i][j]
    end
    j = j + 1
   end
   i = i + 1
  end
 end

 --color functions

 function hc_rcoltorgb(color)
   return {(math.floor(color%8)),(math.floor((color%64)/8)),(math.floor(color/64))}
 end
 function hc_rgbtorcol(red,green,blue)
   return (blue * 64) + (green * 8) + red
 end

 --draw functions
 function hc_draw_pixel(x, y, color)
  if x < 0 or x > 70 or y < 0 or y > 44 or x ~= x or y ~= y then
   return
  end
  r_pixels[x+1][y+1] = color
 end
 function hc_draw_square(x1, y1, x2, y2, color)
  x1 = math.max(0, x1)
  y1 = math.max(0, y1)
  x2 = math.min(70, x2)
  y2 = math.min(44, y2)
  local li = x1
  local lj = y1
  local rpx = r_pixels
  local rp
  while li <= x2 do
   lj = y1
   rp = rpx[li+1]
   while lj <= y2 do
    rp[lj+1] = color
    lj = lj + 1
   end
   li = li + 1
  end
 end
 function hc_draw_square_alpha(x1, y1, x2, y2, color, alpha, xoff, yoff)
  x1 = math.max(0, x1)
  y1 = math.max(0, y1)
  x2 = math.min(70, x2)
  y2 = math.min(44, y2)
  local la = 0
  li = x1 + xoff
  local rpx = r_pixels
  local rp
  while li <= x2 do
   lj = y1 + (la - math.floor(la/2) * 2)/alpha/2 + yoff
   rp = rpx[math.floor(li+1.5)]
   while lj <= y2 do
    rp[math.floor(lj+1)] = color
    lj = lj + 1/alpha
   end
   li = li + math.max(1, 0.5/alpha)
   la = la + 1
  end
 end
 function hc_draw_line(x1, y1, x2, y2, color)
  li = x1
  lj = y1
  local xrat = (x2-x1) / math.abs(y2-y1)
  local yrat = (y2-y1) / math.abs(x2-x1)
  if math.abs(xrat) >= math.abs(yrat) then
   if x2-x1 > 0 then
    while li <= x2 do
     r_pixels[math.max(1,math.min(71,math.floor(li+1.5)))][math.max(1,math.min(45,math.floor(lj+1.5)))] = color
     li = li + 1
     lj = lj + yrat
    end
   elseif x2-x1 < 0 then
    while li >= x2 do
     r_pixels[math.max(1,math.min(71,math.floor(li+1.5)))][math.max(1,math.min(45,math.floor(lj+1.5)))] = color
     li = li - 1
     lj = lj + yrat
    end
   end
  else
   if y2-y1 > 0 then
    while lj <= y2 do
     r_pixels[math.max(1,math.min(71,math.floor(li+1.5)))][math.max(1,math.min(45,math.floor(lj+1.5)))] = color
     li = li + xrat
     lj = lj + 1
    end
   elseif y2-y1 < 0 then
    while lj >= y2 do
     r_pixels[math.max(1,math.min(71,math.floor(li+1.5)))][math.max(1,math.min(45,math.floor(lj+1.5)))] = color
     li = li + xrat
     lj = lj - 1
    end
   end
  end
 end


 function program_refresh()
 end

 r_program_on = 0
 r_program = false
 --local beta_printer = string.upper("beta")
 player.chat("console v1.4.1 successfully initialized!",0x00ff00)
end

r_frames = r_frames + 1
control_horizontal = tolua(player.xvelocity)
r_fpr = settings_fpr
if math.floor(r_frames/r_fpr) == r_frames/r_fpr then
 screen_refresh()
end
if r_program_on == 1 then
  if r_program == false then
    r_program = true
    hc_draw_square(0, 0, 70, 44, 0)
  end
  if prgmpass == false then
    player.chat("an error occurred last frame! enable debug mode to catch errors.", 0xff0000)
    if r_errexit then player_exit() end
    prgmpass = true
    return
  end
  prgmpass = false
  if r_debug then
    if not xpcall(program_refresh, function(err)
      player.chat("an error occurred this frame: "..tostring(err), 0xff0000)
      if r_errexit then player_exit() end
      prgmpass = true
    end) then
      return
    end
  else
    program_refresh()
  end
  prgmpass = true
end
control_up = 0
