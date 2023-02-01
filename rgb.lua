_G.yc={
	r=255,
	g=0,
	b=0,
	incr=2.5
}
_G.cng={
	rg=false,
	gg=true,
	bg=false,
	rl=false,
	gl=false,
	bl=false
}
_G.rgbresult={
	result={
		ac={
			nested={
				actualresult={
					r,
					g,
					b
				}
			}
		}
	}
}
function rgb()
	if _G.cng.rg then _G.yc.r=_G.yc.r+_G.yc.incr end
	if _G.cng.gg then _G.yc.g=_G.yc.g+_G.yc.incr end
	if _G.cng.bg then _G.yc.b=_G.yc.b+_G.yc.incr end
	if _G.cng.rl then _G.yc.r=_G.yc.r-_G.yc.incr end
	if _G.cng.gl then _G.yc.g=_G.yc.g-_G.yc.incr end
	if _G.cng.bl then _G.yc.b=_G.yc.b-_G.yc.incr end
	if _G.yc.r>255 then
		_G.cng.rg=false
		_G.yc.r=255
	end
	if _G.yc.g>255 then
		_G.cng.gg=false
		_G.yc.g=255
	end
	if _G.yc.b>255 then
		_G.cng.gg=false
		_G.yc.b=255
	end
	if _G.yc.r<0 then
		_G.cng.rl=false
		_G.yc.r=0
	end
	if _G.yc.g<0 then
		_G.cng.gl=false
		_G.yc.g=0
	end
	if _G.yc.b<0 then
		_G.cng.bl=false
		_G.yc.b=0
	end
	if _G.yc.r==255 and _G.yc.g==0 and _G.yc.b==0 then
		_G.cng.gg=true
		_G.cng.gl=false
	end
	if _G.yc.r==255 and _G.yc.g==255 and _G.yc.b==0 then
		_G.cng.rl=true
		_G.cng.rg=false
	end
	if _G.yc.r==0 and _G.yc.g==255 and _G.yc.b==0 then
		_G.cng.bg=true
		_G.cng.bl=false
	end
	if _G.yc.r==0 and _G.yc.g==255 and _G.yc.b==255 then
		_G.cng.gl=true
		_G.cng.gg=false
	end
	if _G.yc.r==0 and _G.yc.g==0 and _G.yc.b==255 then
		_G.cng.rg=true
		_G.cng.rl=false
	end
	if _G.yc.r==255 and _G.yc.g==0 and _G.yc.b==255 then
		_G.cng.bl=true
		_G.cng.bg=false
	end
	wait()
	_G.rgbresult.result.ac.nested.actualresult.r=_G.yc.r
	_G.rgbresult.result.ac.nested.actualresult.g=_G.yc.g
	_G.rgbresult.result.ac.nested.actualresult.b=_G.yc.b
	rgb()
end
rgb()
