--key states
gkey,rkey,bkey,okey,pkey,ckey = false,false,false,false,false,false
--key timers
gktimer,rktimer,bktimer,oktimer,pktimer,cktimer = 0,0,0,0,0,0
FOUR = 109 --constant of duration

--change state and timer
setkey = {
          function(k,t) gkey=k gktimer=t end,
          function(k,t) rkey=k rktimer=t end,
          function(k,t) bkey=k bktimer=t end,
          function(k,t) okey=k oktimer=t end,
          function(k,t) pkey=k pktimer=t end,
          function(k,t) ckey=k cktimer=t end
         }

--get state and timer
getkey = {
          function() return {k=gkey,t=gktimer} end,
          function() return {k=rkey,t=rktimer} end,
          function() return {k=bkey,t=bktimer} end,
          function() return {k=okey,t=oktimer} end,
          function() return {k=pkey,t=pktimer} end,
          function() return {k=ckey,t=cktimer} end
         }

--color is xpos of the grid which is 2x2, this goes from -2 to -1
function activatekey(color)
   local c = color*2
   for i = -2,-1 do
      game.level.switchblocks(c,i, c+1,i)
   end
end

--this runs the system of keys. its better you dont touch it.
function runkey(color)
   local key = getkey[color+1]()
   if key.t == FOUR then
      if not key.k then
         activatekey(color)
      end
      setkey[color+1](true,FOUR-1)
      player.postGameEvent(color)
   elseif key.k and key.t <= 0 then
      activatekey(color)
      setkey[color+1](false,0)
   elseif key.t > 0 then
      setkey[color+1](key.k, key.t-1)
   end
end

game.start.addListener(function()
   player.hurt(0)
   player.speed,player.accel,player.jump = 80,80,100

   player.tick.addListener(function()
      --make sure to check all your keys
      for i = 0,5 do
         runkey(i)
      end
   end)
end)
      
game.gameEvent.addListener(function(event)
   info = tolua(event.data)
   if not getkey[info+1]().k then
      activatekey(info)
   end
   setkey[info+1](true,FOUR-1)
end)
