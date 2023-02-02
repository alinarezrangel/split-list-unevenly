-- Our flatten function. Flattens a table of tables.
function flatten(tbls)
   local r = {}
   for i = 1, #tbls do
      local tbl = tbls[i]
      table.move(tbl, 1, #tbl, #r + 1, r)
   end
   return r
end

-- Sum all the values in a list.
function sum(arr)
   local r = 0
   for i = 1, #arr do
      r = r + arr[i]
   end
   return r
end

function gcd(a, b)
   if b == 0 then
      return a
   else
      return gcd(b, a % b)
   end
end

-- Return a list containing el n-times.
function rept(el, n)
   local r = {}
   for i = 1, n do
      r[#r + 1] = el
   end
   return r
end

function split_helper(m, n)
   assert(m >= n, "cannot split an m-elements array into n parts if n > m")
   assert(n >= 1, "n must be greater than or equal to 1 when splitting")
   if n == 1 then
      return {m}
   end
   if m % n == 0 then
      return rept(m // n, n)
   end
   local g = gcd(m, n)
   if g > 1 then
      return flatten(rept(split_helper(m // g, n // g), g))
   end
   assert(g == 1)
   local e = m % n
   local mp = m - e
   local Rp = split_helper(mp, n)
   local Rpp = {}
   assert(#Rp > 0)
   Rpp[1] = Rp[1]
   
   for i = 2, #Rp do
      local a = (e * (i - 1)) % n
      local d = math.floor((a + e) / n)
      if a + e < n then
         Rpp[i] = Rp[i]
      else
         Rpp[i] = Rp[i] + d
      end
   end
   return Rpp
end

function split(arr, n)
   local lens = split_helper(#arr, n)
   assert(sum(lens) == #arr)
   assert(#lens == n)
   local r = {}
   local p = 1
   for i = 1, #lens do
      local len = lens[i]
      r[#r + 1] = {}
      table.move(arr, p, p + len - 1, 1, r[#r])
      p = p + len
   end
   return r
end
