class Car_maker
    attr_accessor:car_maker, :car_inventory, :catalog
    @@catalog = []
    
    def initialize(car_maker)
        @car_maker = car_maker
        #@@catalog.push
    end
    def Car_maker.set_catalog(array)
        @@catalog = array
    end
    def Car_maker.print_catalog
        puts "-----------Read file and instantiates the following cars:-----------"
        puts "--------------------------------------------------------------------"
        for i in 0..(@@catalog.length-1)
            puts @@catalog[i].print_car
        end
    end
    def Car_maker.searchInventory(input)
        hash = Hash.new
        hash = input
        string = hash.keys
        for i in 0..(@@catalog.size-1)
        #Car_maker.print_catalog
            for j in 0..(string.size)
                if (@@catalog[i].car_maker == hash["#{string[j]}"])
                    @@catalog[i].print_car
                end
            end
        end
    end
    def Car_maker.searchInventory_string(input)
        hash = Hash.new
        hash = input
        string = hash.keys
        res =""
        for i in 0..(@@catalog.size-1)
        #Car_maker.print_catalog
            for j in 0..(string.size)
                if (@@catalog[i].car_maker == hash["#{string[j]}"])
                    res += "\n#{@@catalog[i].car_maker}, #{@@catalog[i].model}, #{@@catalog[i].trim}, #{@@catalog[i].km}, #{@@catalog[i].year}, #{@@catalog[i].type}, #{@@catalog[i].drivertrain}, #{@@catalog[i].transmission}, #{@@catalog[i].stock_number}, #{@@catalog[i].status}, #{@@catalog[i].fuel_economy}, {#{@@catalog[i].features}}"
                end
            end
        end
        return res
    end
    def Car_maker.saveCatalogue2File
        file = File.open("output.txt", 'w')
            string =""
                string += Car_maker.searchInventory_string({"car_maker" => "BMW"})
                string +=  Car_maker.searchInventory_string({"car_maker" => "Honda"})
                string +=  Car_maker.searchInventory_string({"car_maker" => "Lexus"})
                string +=  Car_maker.searchInventory_string({"car_maker" => "Mercedes"})
                string +=  Car_maker.searchInventory_string({"car_maker" => "Toyota"})
        file.write("#{string}")
        puts "-----The catalog file has been created, please see output.txt-------"
        puts "--------------------------------------------------------------------"
    end
end

class Car_model < Car_maker
    attr_accessor:km, :type, :transmission, 
                 :drivertrain, :status, :fuel_economy, 
                 :car_maker, :model, :year, :trim, :features, :stock_number
    def initialize ( km, type, transmission, drivertrain, status, fuel_economy,car_maker, model, year, trim, features, stock_number)
        #@super (@car_maker) 
        @km = km
        @type = type
        @transmission = transmission
        @drivertrain = drivertrain
        @status = status
        @fuel_economy = fuel_economy
        @car_maker = car_maker
        @model = model
        @year = year
        @trim = trim
        @features = features
        @stock_number = stock_number
    end
    
    def print_car
        puts "#{@car_maker}, #{@model}, #{@trim}, #{@km}, #{@year}, #{@type}, #{@transmission}, #{@status}, #{@fuel_economy}, {#{@features}}, #{@stock_number}"
    end
end

def convertListings2Catalougue(string)
    count = 0
    line_num=0
    car_models = []
    file = File.open(string)
    text=file.read
    text.gsub!(/\r\n?/, "\n")
    ###reads the listings file line by line
    text.each_line do |line|
        #print line
        count += 1
            ###correctly recognizes and extracts different listing features
            @features = line[/.*{([^}]*)/,1] 
            line.slice!line[/.*{([^}]*)/,1] 
            @fuel_economy = line[/(\d+L\W100km)/,1]
            line.slice!line[/(\d+L\W100km)/,1]
            @drivertrain = line[/(FWD|RWD|AWD)/,1]
            line.slice!line[/(FWD|RWD|AWD)/,1]
            @km = line[/(\d*km)/,1]
            line.slice!line[/(\d*km)/,1]
            @type = line[/(Sedan|coupe|hatchback|station|SUV)/,1]
            line.slice!line[/(Sedan|coupe|hatchback|station|SUV)/,1]
            @status = line[/(Used|new)/,1]
            line.slice!line[/(Used|new)/,1]
            @transmission = line[/(Auto|auto|Manual|manual|Steptronic|steptronic)/,1]
            line.slice!line[/(Auto|auto|Manual|manual|Steptronic|steptronic)/,1]
            @car_maker = line[/(Honda|Toyota|Mercedes|Mercedec|BMW|Lexus)/,1]
            line.slice!line[/(Honda|Toyota|Mercedes|Mercedec|BMW|Lexus)/,1]
            @model = line[/([a-zA-Z]{3,})/,1]
            line.slice!line[/([a-zA-Z]{3,})/,1]
            @trim = line[/([A-Z]{2})/,1]
            line.slice!line[/([A-Z]{2})/,1]
            @stock_number = line[/((\d|\w){5,}[^km,])/,1]
            line.slice!line[/((\d|\w){5,}[^km,])/,1]
            @year = line[/([12][0-9]{3})/,1]
            line.slice!line[/([12][0-9]{3})/,1]

            car_model = Car_model.new(@km, @type, @transmission, @drivertrain, @status, @fuel_economy, 
                     @car_maker, @model, @year, @trim, @features, @stock_number)
            car_models[count-1] = car_model
            #car_models[count-1].km
            #puts count
    end
    ###instantiates appropriate objects of cars
    Car_maker.set_catalog(car_models)
    return car_models
end

def add2Inventory(listing)
    File.open("listings.txt", 'a') { |file| file.write("\n#{listing}") }
    car_models = convertListings2Catalougue("listings.txt")
    puts "-----The new entry has been added, please see listings.txt-------"
    puts "--------------------------------------------------------------------"
end
puts "--------------------------------------------------------------------"
puts "--------------Test \"convertListings2Catalougue\" Method--------------"
car_models = convertListings2Catalougue("listings.txt")
Car_maker.print_catalog
puts ""
puts "--------------------------------------------------------------------"
puts "-------------------Test \"searchInventory\" Method-------------------"
puts "-----------------------Display all Mercedes Cars--------------------"
puts "--------------------------------------------------------------------"
Car_maker.searchInventory({"car_maker" => "Mercedes"})
#Car_maker.searchInventory({"car_maker" => "Honda"})
#Car_maker.searchInventory({"car_maker" => "Toyota"})
puts ""
puts "--------------------------------------------------------------------"
puts "-------------------Test \"add2Inventory\" Method-------------------"
add2Inventory("RWD,SUV,1000000km,auto,new,Honda,CRV,LE,19BF723A,100000L/100km,2020,{Heated Seats, Heated Mirrors, Keyless Entry}")
puts ""
puts "--------------------------------------------------------------------"
puts "-------------------Test \"saveCatalogue2File\" Method-------------------"
Car_maker.saveCatalogue2File
