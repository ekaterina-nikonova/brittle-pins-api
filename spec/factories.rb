FactoryBot.define do
  factory :project do
    name { 'test project name' }
    description { 'test project description' }

    factory :project_with_components do
      transient do
        components_count { 18 }
      end

      after(:create) do |project, evaluator|
        create_list(:component, evaluator.components_count, projects: [project], user: project.user )
      end
    end
  end

  factory :chapter do
    name { 'test chapter' }
    intro { 'test chapter intro' }
  end

  factory :section do
    paragraph { 'test section paragraph' }
    code { 'test section code' }

    trait :with_image do
      image { fixture_file_upload(
          Rails.root.join('spec', 'support', 'assets', 'test.png')
      )}
    end
  end

  factory :invitation do
    sequence(:email) { |n| "user#{n}@example.com" }
    expires_at { 1.week.from_now }
  end

  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'test1234' }
    password_confirmation { 'test1234' }
  end

  factory :component do
    name { 'test component name' }
    description { 'test component description' }

    factory :component_with_projects do
      transient do
        projects_count { 19 }
      end

      after(:create) do |component, evaluator|
        create_list(:project, evaluator.projects_count, components: [component], board: component.boards.first, user: component.user)
      end
    end
  end

  factory :board do
    name { 'test board name' }
    description { 'test board description' }

    factory :board_with_components do
      transient do
        components_count { 15 }
      end

      after(:create) do |board, evaluator|
        create_list(:component, evaluator.components_count, boards: [board], user: board.user )
      end
    end

    factory :board_with_projects do
      transient do
        projects_count { 13 }
      end

      after(:create) do |board, evaluator|
        create_list(:project, evaluator.projects_count, board: board, user: board.user )
      end
    end

    trait :with_image do
      image { fixture_file_upload(
        Rails.root.join('spec', 'support', 'assets', 'test.png')
      )}
    end
  end
end
