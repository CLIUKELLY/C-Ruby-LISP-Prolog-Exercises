def sort_and_count(array) #define sort and count function
    @sorted_name=array.sort
    @sorted_name.each { |i| puts "#{i},ch_count= #{i.length}" }
end

sort_and_count(["Adam","Eve","Mark","Franklin","John"]) #call sort and count function, and pass value
