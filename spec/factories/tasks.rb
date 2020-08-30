FactoryBot.define do
  factory :task do
    name {'テストをかく'}
    description {'RspecとcapybaraとFactorybot'}
    user
  end
end