namespace :omg do
  data = ENV['data']

  desc "Generate submission table and output in stdout"
  task :submission do |t|
    puts OMGSeq::Table.new(data).create_submission
  end

  desc "Generate supplementary table and output in stdout"
  task :supplementary do |t|
    puts OMGSeq::Table.new(data).create_supplementary
  end
end
