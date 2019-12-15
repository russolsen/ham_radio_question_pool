require 'yaml'
require 'json'

module Quiz
  def self.json_load(path)
    JSON.parse(File.read(path), symbolize_names: true)
  end

  def self.json_dump(data, path)
    open(path, 'w') {|f| f.puts(JSON.pretty_generate(data))}
  end

  def self.randomize_question(q)
    correct = q[:answers][q[:correct]]
    q[:answers].shuffle!
    q[:correct] = q[:answers].index(correct)
    q
  end

  def self.subelement(q)
    i = q[:id]
    i[0,3]
  end

  def self.organize_by_subelement(qs)
    index = {}
    qs.each do |q|
      se = subelement(q)
      index[se]=[] if index[se].nil?
      index[se] << q
    end
    index
  end

  def self.organize_by_id(qs)
    index = {}
    qs.each do |q|
      qid = q[:id]
      index[qid] = q
    end
    index
  end

  def self.random_test(pool)
    test = []
    pool.each do |subel, questions|
      test << questions.sample
    end
    test
  end

  def self.read_question_pool(path)
    questions = json_load(path)
    p questions
    questions.map! {|q| randomize_question(q)}
    organize_by_subelement(questions)
  end

  def self.make_random_test(path)
    pool = read_question_pool(path)
    random_test(pool)
  end

  def self.make_test_from_file(path)
    questions = read_questions(path)
    questions.map! {|q| randomize_question(q)}
    questions
  end

  def self.save_results(results, path)
    wrong = results.delete_if {|q| q[:answered_correctly]}
    open(path, 'w') {|f| f.puts(YAML.dump(wrong))}
  end

  def self.letter_to_i(l)
    l.ord - 'a'.ord
  end

  def self.i_to_letter(i)
    "abcd"[i]
  end

  def self.read_letter
    resp = ''
    until /[abcd]/ =~ resp
      resp = gets.strip
    end
    resp
  end

  def self.prompt(s)
    print "#{s}> "
    gets.strip
  end

  def self.prompt_letter(s)
    print "#{s}> "
    read_letter
  end

  def self.print_question(q)
    puts "#{q[:id]} - #{q[:question]} "
    answers = q[:answers]
    answers.each_with_index do |a, i|
      puts "#{i_to_letter(i)}) #{a}"
    end
  end

  def self.ask_question(q)
    print_question(q)
    l = prompt_letter("answer>")
    i = letter_to_i(l)
    return i
  end

  def self.flash_question(q)
    #puts "#{q[:id]} - #{q[:question]} "
    print_question q
    icorrect = q[:correct]
    answers = q[:answers]
    resp = nil
    right_first_time = true
    while resp != icorrect
      resp = letter_to_i(prompt_letter "Your answer")
      #puts resp, icorrect
      if resp == icorrect
        puts "Correct!"
      else
        right_first_time = false
        puts "Nope: #{answers[icorrect]}"
      end 
    end
    puts
    return right_first_time
  end

  def self.run_flash(questions)
    until questions.empty?
      n = questions.count
      correct_ids = []
      questions.shuffle!
      next_questions = questions.clone
      questions.each_with_index do |q, i|
        print "#{i+1}/#{n} "
        right = flash_question(q)
        if right
          next_questions = next_questions.delete_if do |question|
            question[:id] == q[:id]
          end
        end
      end
      questions = next_questions
      puts "**new questions #{questions.count}"
    end
  end

  def self.run_test(questions)
    n = questions.count
    questions.each_with_index do |q, i|
      #puts "Question #{q}"
      puts "#{i+1}/#{n}"
      answer = ask_question(q)
      q[:response] = answer
      q[:answered_correctly] = (answer == q[:correct])
    end
    questions
  end

  def self.test_summary(test)
    test.map do |q|
      [q[:id], q[:answered_correctly]]
    end
  end

  def self.wrong_answers(results)
    results.delete_if {|q| q[:answered_correctly]}
  end

  def self.wrong_ids(results)
    wrong_answers(results).map {|q| q[:id]}
  end

  def self.test_from_ids(ids, all_questions)
    test=[]
    ids.each do |qid|
      i = all_questions.index {|q| q[:id] == qid}
      test << all_questions[i]
    end
  end
end

