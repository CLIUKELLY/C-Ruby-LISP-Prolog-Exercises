def calcARI(string)
    char_number = 0
    word_number = 0
    sentence_number = 0
    File.open("#{string}","r") do |file|
        
        for line in file.readlines()
            puts line
            char_number += line.gsub(/\s+/,'').size
            word_number += line.split(/\s+/).length
            sentence_number += line.count(".")
        end
    end
    ari = 4.71 * (char_number / word_number) + 0.5 * (word_number / sentence_number) - 21.43
    statement = ""
    x = ari.to_i
    case x
    when 1
        statement = "5-6 (Kindergarten)"
    when 2
        statement = "6-7 (First/Second Grade)"
    when 3
        statement = "7-9 (Third Grade)"
    when 4
        statement = "9-10 (Fourth Grade)"
    when 5
        statement = "10-11 (Fifth Grade)"
    when 6
        statement = "11-12 (Sixth Grade)"
    when 7
        statement = "12-13 (Seventh Grade)"
    when 8
        statement = "13-14 (Eighth Grade)"
    when 9
        statement = "14-15 (Ninth Grade)"
    when 10
        statement = "15-16 (Tenth Grade)"
    when 11
        statement = "16-17 (Eleventh Grade)"
    when 12
        statement = "17-18 (Twelfth grade)"
    when 13
        statement = "18-24 (College student)"
    when 14
        statement = "24+ (Professor)"
    end
   
    puts ""
    puts "Total # of characters: " + char_number.to_s
    puts "Total # of words: " + word_number.to_s
    puts "Total # of sentences: " + sentence_number.to_s
    puts "Automated Readability Index: " + ari.round(1).to_s
    puts "Grade level: " + statement
end

calcARI("paragraph.txt")
