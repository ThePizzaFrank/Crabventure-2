module(...,package.seeall)

--min heap
function binaryHeap()
  local BinaryHeap = {
      heapArray = {},
      current_heap_size = 0,
      insert = function(self, priority, item)
        local i = self.current_heap_size
        local item = {
          priority = priority,
          value = item
        }
        self.heapArray[i] = item
        self.current_heap_size = self.current_heap_size + 1

        while i ~= 0 and self.heapArray[i].priority < self.heapArray[self.parent(i)].priority do
            self:swap(i,self.parent(i))
            i = self.parent(i);
        end
        return true;
      end,

      pop = function(self)
        if self.current_heap_size <= 0 then
          return false
        end

        root = self.heapArray[0]

        if self.current_heap_size == 1 then
          self.current_heap_size = self.current_heap_size - 1
          self.heapArray = {}
          return root.value
        end

        self.heapArray[0] = self.heapArray[self.current_heap_size - 1]
        self.heapArray[self.current_heap_size - 1] = nil
        self.current_heap_size = self.current_heap_size - 1
        self:minHeapify(0);

        return root.value;
      end,

      print = function(self)
        local str = ""
        for x,v in pairs(self.heapArray) do
          str = str..v.value..","
        end
        print(str)
      end,
      swap = function(self,e1,e2)
        local temp = self.heapArray[e1]
        self.heapArray[e1] = self.heapArray[e2]
        self.heapArray[e2] = temp
      end,
      parent = function(key)
        return math.floor((key - 1)/2)
      end,
      left = function(key)
        return 2 * key + 1
      end,
      right = function(key)
        return 2 * key + 2
      end,
      minHeapify = function(self, key)
        local l = self.left(key);
        local r = self.right(key);

        smallest = key;
        if l < self.current_heap_size and self.heapArray[l].priority < self.heapArray[smallest].priority then
            smallest = l;
        end

        if r < self.current_heap_size and self.heapArray[r].priority < self.heapArray[smallest].priority then
            smallest = r;
        end

        if smallest ~= key then
            self:swap(key,smallest);
            self:minHeapify(smallest);
        end
      end
  }
  return BinaryHeap
end
