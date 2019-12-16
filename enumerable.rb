module Enumerable
    def my_each
        index = 0
        while index < self.length
            yield(self[index])
            index += 1
        end
    end

    def my_each_with_index
        index = 0
        while index < self.length
            yield(self[index], index)
            index += 1
        end
    end

    def my_select
        new_arr = Array.new()
        self.my_each {|elem| new_arr << elem if yield(elem)}
        new_arr
    end

    def my_all?
        result = false
        self.my_each {|elem| yield(elem) ? result = true : result = false }
        result
    end
    def my_any?
        result = false
        self.my_each {|elem| result = true if yield(elem)}
        result
    end
    def my_none?
        result = true
        self.my_each {|elem| result = false if yield(elem)}
        result
    end
    def my_count num = nil
        count = 0
        if num
            self.my_each {|elem| count += 1 if elem == num}
        elsif block_given?
            self.my_each {|elem| count += 1 if yield(elem)}
        else
            count = self.length
        end
        count
    end

    def my_map block = nil
        new_arr = Array.new()

        if block
            self.my_each_with_index {|elem,index| new_arr[index] = block.call(elem)}
        else
            self.my_each_with_index {|elem,index| new_arr[index] = yield(elem)}
        end
        new_arr
    end

    def my_inject initial = nil
        initial == nil ? result = self[0] : result = initial

        for i in 1..self.length - 1
            result = yield(result,self[i])
        end
        result
    end
    
end

test_arr = [100,54,1,2,3,4]
test_string = ["hithere"]

#each
# test_arr.each {|num| puts num * 2}
# test_arr.my_each {|num| puts num * 2}

#each_with_index
# test_arr.each_with_index {|num,i| puts num + i}
# test_arr.my_each_with_index {|num,i| puts num + i}

#select
# print test_arr.select {|num| num % 2 == 0}
# print test_arr.my_select {|num| num % 2 == 0}

#all?
# print test_arr.all? {|num| num.is_a? Integer}
# print test_arr.all? {|word| word.is_a? String}
# print test_arr.my_any? {|num| num.is_a? Integer}
# print test_string.my_all? {|word| word.is_a? String}

#none?
# print test_arr.none? {|num| num.is_a? String}
# print test_arr.none? {|num| num.is_a? Integer}
# print test_arr.my_none? {|num| num.is_a? String}
# print test_arr.my_none? {|num| num.is_a? Integer}

#count
# print test_arr.count {|num| num < 4}
# print test_arr.count(5)
# print test_arr.count

# puts test_arr.my_count {|num| num < 4}
# puts test_arr.my_count(5)
# puts test_arr.my_count

#map
# puts test_arr.map {|num| num*10}
# test_block = Proc.new {|elem| elem * 10}
# puts test_arr.map(&test_block)
# puts test_arr.my_map {|num| num*10}

#inject
print test_arr.inject {|result,elem| result + elem}
print test_arr.my_inject {|result,elem| result + elem}