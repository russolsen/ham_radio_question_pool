
tech_dir = "technician-2018-2022"
gen_dir = "general-2019-2023"
extra_dir = "extra-2016-2020"

process_prog = "../programs/process.rb"

task default: [:technician_formats, :general_formats, :extra_formats]

task :technician_formats => "#{tech_dir}/technician.txt" do
  cd tech_dir do
    ruby process_prog, "technician"
  end
end

task :general_formats => "#{gen_dir}/general.txt" do
  cd gen_dir do
    ruby process_prog, "general"
  end
end

task :extra_formats => "#{extra_dir}/extra.txt" do
  cd extra_dir do
    ruby process_prog, "extra"
  end
end
