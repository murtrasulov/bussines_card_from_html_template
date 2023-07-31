# encoding: utf-8
#
# Программа, которая генерирует визитку в html, используя шаблон
#
# ---
# Этот код необходим только при использовании русских букв на Windows
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end
# ---

# Созраним путь к шаблону в переменную template_path
template_path = File.dirname(__FILE__) + '/template.html'

# Если шаблона нет заканчиваем программу
unless File.exist?(template_path)
  abort "Не удалось найти шаблон #{template_path}"
end

# Считываем содержимое шаблона в переменную template
template = File.read(template_path, encoding: 'UTF-8')

puts 'Программа создаст визитку на основе ваших данных.'
puts

# В ассоциативном массиве answers будем хранить ответы пользователя
answers = {}

# Спрашиваем у пользователя все необходимые данные
puts
puts 'Введите имя и Фамилию:'
answers[:name] = gets.chomp

puts
puts 'Введите должность:'
answers[:employment] = gets.chomp

puts
puts 'Введите url фотографии:'
answers[:image_url] = gets.chomp

puts
puts 'Введите номер телефона'
answers[:phone] = gets.chomp

puts
puts 'Введите Email'
answers[:email] = gets.chomp

# Вставляем данные в шаблон простым gsub - ом
answers.each do |field_name, user_input|
  template.gsub!("%{#{field_name}}", user_input)
end

# Созраняем визитку в новый файл и сообщаем об этом пользователю
business_card_path = "#{Time.now.strftime('%Y-%m-%d_%H-%M')}.html"

File.open(business_card_path, 'w:UTF-8') { |file| file.write template }
puts
puts "Ваша визитка сохранена в файл #{business_card_path}"


