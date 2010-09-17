# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{searchlogic}
  s.version = "1.6.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ben Johnson of Binary Logic"]
  s.date = %q{2009-04-02}
  s.description = %q{Object based ActiveRecord searching, ordering, pagination, and more!}
  s.email = %q{bjohnson@binarylogic.com}
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "lib/searchlogic/active_record/associations.rb", "lib/searchlogic/active_record/base.rb", "lib/searchlogic/active_record/connection_adapters/mysql_adapter.rb", "lib/searchlogic/active_record/connection_adapters/postgresql_adapter.rb", "lib/searchlogic/active_record/connection_adapters/sqlite_adapter.rb", "lib/searchlogic/condition/base.rb", "lib/searchlogic/condition/begins_with.rb", "lib/searchlogic/condition/blank.rb", "lib/searchlogic/condition/child_of.rb", "lib/searchlogic/condition/descendant_of.rb", "lib/searchlogic/condition/ends_with.rb", "lib/searchlogic/condition/equals.rb", "lib/searchlogic/condition/greater_than.rb", "lib/searchlogic/condition/greater_than_or_equal_to.rb", "lib/searchlogic/condition/inclusive_descendant_of.rb", "lib/searchlogic/condition/keywords.rb", "lib/searchlogic/condition/less_than.rb", "lib/searchlogic/condition/less_than_or_equal_to.rb", "lib/searchlogic/condition/like.rb", "lib/searchlogic/condition/nested_set.rb", "lib/searchlogic/condition/nil.rb", "lib/searchlogic/condition/not_begin_with.rb", "lib/searchlogic/condition/not_blank.rb", "lib/searchlogic/condition/not_end_with.rb", "lib/searchlogic/condition/not_equal.rb", "lib/searchlogic/condition/not_have_keywords.rb", "lib/searchlogic/condition/not_like.rb", "lib/searchlogic/condition/not_nil.rb", "lib/searchlogic/condition/sibling_of.rb", "lib/searchlogic/conditions/any_or_all.rb", "lib/searchlogic/conditions/base.rb", "lib/searchlogic/conditions/groups.rb", "lib/searchlogic/conditions/magic_methods.rb", "lib/searchlogic/conditions/multiparameter_attributes.rb", "lib/searchlogic/conditions/protection.rb", "lib/searchlogic/config/helpers.rb", "lib/searchlogic/config/search.rb", "lib/searchlogic/config.rb", "lib/searchlogic/core_ext/hash.rb", "lib/searchlogic/core_ext/object.rb", "lib/searchlogic/helpers/control_types/link.rb", "lib/searchlogic/helpers/control_types/links.rb", "lib/searchlogic/helpers/control_types/remote_link.rb", "lib/searchlogic/helpers/control_types/remote_links.rb", "lib/searchlogic/helpers/control_types/remote_select.rb", "lib/searchlogic/helpers/control_types/select.rb", "lib/searchlogic/helpers/form.rb", "lib/searchlogic/helpers/utilities.rb", "lib/searchlogic/modifiers/absolute.rb", "lib/searchlogic/modifiers/acos.rb", "lib/searchlogic/modifiers/asin.rb", "lib/searchlogic/modifiers/atan.rb", "lib/searchlogic/modifiers/avg.rb", "lib/searchlogic/modifiers/base.rb", "lib/searchlogic/modifiers/ceil.rb", "lib/searchlogic/modifiers/char_length.rb", "lib/searchlogic/modifiers/cos.rb", "lib/searchlogic/modifiers/cot.rb", "lib/searchlogic/modifiers/count.rb", "lib/searchlogic/modifiers/day_of_month.rb", "lib/searchlogic/modifiers/day_of_week.rb", "lib/searchlogic/modifiers/day_of_year.rb", "lib/searchlogic/modifiers/degrees.rb", "lib/searchlogic/modifiers/exp.rb", "lib/searchlogic/modifiers/floor.rb", "lib/searchlogic/modifiers/hex.rb", "lib/searchlogic/modifiers/hour.rb", "lib/searchlogic/modifiers/log.rb", "lib/searchlogic/modifiers/log10.rb", "lib/searchlogic/modifiers/log2.rb", "lib/searchlogic/modifiers/lower.rb", "lib/searchlogic/modifiers/ltrim.rb", "lib/searchlogic/modifiers/md5.rb", "lib/searchlogic/modifiers/microseconds.rb", "lib/searchlogic/modifiers/milliseconds.rb", "lib/searchlogic/modifiers/minute.rb", "lib/searchlogic/modifiers/month.rb", "lib/searchlogic/modifiers/octal.rb", "lib/searchlogic/modifiers/radians.rb", "lib/searchlogic/modifiers/round.rb", "lib/searchlogic/modifiers/rtrim.rb", "lib/searchlogic/modifiers/second.rb", "lib/searchlogic/modifiers/sign.rb", "lib/searchlogic/modifiers/sin.rb", "lib/searchlogic/modifiers/square_root.rb", "lib/searchlogic/modifiers/sum.rb", "lib/searchlogic/modifiers/tan.rb", "lib/searchlogic/modifiers/trim.rb", "lib/searchlogic/modifiers/upper.rb", "lib/searchlogic/modifiers/week.rb", "lib/searchlogic/modifiers/year.rb", "lib/searchlogic/search/base.rb", "lib/searchlogic/search/conditions.rb", "lib/searchlogic/search/ordering.rb", "lib/searchlogic/search/pagination.rb", "lib/searchlogic/search/protection.rb", "lib/searchlogic/search/searching.rb", "lib/searchlogic/shared/utilities.rb", "lib/searchlogic/shared/virtual_classes.rb", "lib/searchlogic/version.rb", "lib/searchlogic.rb", "README.rdoc", "TODO.rdoc"]
  s.files = ["CHANGELOG.rdoc", "init.rb", "lib/searchlogic/active_record/associations.rb", "lib/searchlogic/active_record/base.rb", "lib/searchlogic/active_record/connection_adapters/mysql_adapter.rb", "lib/searchlogic/active_record/connection_adapters/postgresql_adapter.rb", "lib/searchlogic/active_record/connection_adapters/sqlite_adapter.rb", "lib/searchlogic/condition/base.rb", "lib/searchlogic/condition/begins_with.rb", "lib/searchlogic/condition/blank.rb", "lib/searchlogic/condition/child_of.rb", "lib/searchlogic/condition/descendant_of.rb", "lib/searchlogic/condition/ends_with.rb", "lib/searchlogic/condition/equals.rb", "lib/searchlogic/condition/greater_than.rb", "lib/searchlogic/condition/greater_than_or_equal_to.rb", "lib/searchlogic/condition/inclusive_descendant_of.rb", "lib/searchlogic/condition/keywords.rb", "lib/searchlogic/condition/less_than.rb", "lib/searchlogic/condition/less_than_or_equal_to.rb", "lib/searchlogic/condition/like.rb", "lib/searchlogic/condition/nested_set.rb", "lib/searchlogic/condition/nil.rb", "lib/searchlogic/condition/not_begin_with.rb", "lib/searchlogic/condition/not_blank.rb", "lib/searchlogic/condition/not_end_with.rb", "lib/searchlogic/condition/not_equal.rb", "lib/searchlogic/condition/not_have_keywords.rb", "lib/searchlogic/condition/not_like.rb", "lib/searchlogic/condition/not_nil.rb", "lib/searchlogic/condition/sibling_of.rb", "lib/searchlogic/conditions/any_or_all.rb", "lib/searchlogic/conditions/base.rb", "lib/searchlogic/conditions/groups.rb", "lib/searchlogic/conditions/magic_methods.rb", "lib/searchlogic/conditions/multiparameter_attributes.rb", "lib/searchlogic/conditions/protection.rb", "lib/searchlogic/config/helpers.rb", "lib/searchlogic/config/search.rb", "lib/searchlogic/config.rb", "lib/searchlogic/core_ext/hash.rb", "lib/searchlogic/core_ext/object.rb", "lib/searchlogic/helpers/control_types/link.rb", "lib/searchlogic/helpers/control_types/links.rb", "lib/searchlogic/helpers/control_types/remote_link.rb", "lib/searchlogic/helpers/control_types/remote_links.rb", "lib/searchlogic/helpers/control_types/remote_select.rb", "lib/searchlogic/helpers/control_types/select.rb", "lib/searchlogic/helpers/form.rb", "lib/searchlogic/helpers/utilities.rb", "lib/searchlogic/modifiers/absolute.rb", "lib/searchlogic/modifiers/acos.rb", "lib/searchlogic/modifiers/asin.rb", "lib/searchlogic/modifiers/atan.rb", "lib/searchlogic/modifiers/avg.rb", "lib/searchlogic/modifiers/base.rb", "lib/searchlogic/modifiers/ceil.rb", "lib/searchlogic/modifiers/char_length.rb", "lib/searchlogic/modifiers/cos.rb", "lib/searchlogic/modifiers/cot.rb", "lib/searchlogic/modifiers/count.rb", "lib/searchlogic/modifiers/day_of_month.rb", "lib/searchlogic/modifiers/day_of_week.rb", "lib/searchlogic/modifiers/day_of_year.rb", "lib/searchlogic/modifiers/degrees.rb", "lib/searchlogic/modifiers/exp.rb", "lib/searchlogic/modifiers/floor.rb", "lib/searchlogic/modifiers/hex.rb", "lib/searchlogic/modifiers/hour.rb", "lib/searchlogic/modifiers/log.rb", "lib/searchlogic/modifiers/log10.rb", "lib/searchlogic/modifiers/log2.rb", "lib/searchlogic/modifiers/lower.rb", "lib/searchlogic/modifiers/ltrim.rb", "lib/searchlogic/modifiers/md5.rb", "lib/searchlogic/modifiers/microseconds.rb", "lib/searchlogic/modifiers/milliseconds.rb", "lib/searchlogic/modifiers/minute.rb", "lib/searchlogic/modifiers/month.rb", "lib/searchlogic/modifiers/octal.rb", "lib/searchlogic/modifiers/radians.rb", "lib/searchlogic/modifiers/round.rb", "lib/searchlogic/modifiers/rtrim.rb", "lib/searchlogic/modifiers/second.rb", "lib/searchlogic/modifiers/sign.rb", "lib/searchlogic/modifiers/sin.rb", "lib/searchlogic/modifiers/square_root.rb", "lib/searchlogic/modifiers/sum.rb", "lib/searchlogic/modifiers/tan.rb", "lib/searchlogic/modifiers/trim.rb", "lib/searchlogic/modifiers/upper.rb", "lib/searchlogic/modifiers/week.rb", "lib/searchlogic/modifiers/year.rb", "lib/searchlogic/search/base.rb", "lib/searchlogic/search/conditions.rb", "lib/searchlogic/search/ordering.rb", "lib/searchlogic/search/pagination.rb", "lib/searchlogic/search/protection.rb", "lib/searchlogic/search/searching.rb", "lib/searchlogic/shared/utilities.rb", "lib/searchlogic/shared/virtual_classes.rb", "lib/searchlogic/version.rb", "lib/searchlogic.rb", "Manifest", "MIT-LICENSE", "Rakefile", "README.rdoc", "test/active_record_tests/associations_test.rb", "test/active_record_tests/base_test.rb", "test/condition_tests/base_test.rb", "test/condition_tests/begins_with_test.rb", "test/condition_tests/blank_test.rb", "test/condition_tests/child_of_test.rb", "test/condition_tests/descendant_of_test.rb", "test/condition_tests/ends_with_test.rb", "test/condition_tests/equals_test.rb", "test/condition_tests/greater_than_or_equal_to_test.rb", "test/condition_tests/greater_than_test.rb", "test/condition_tests/inclusive_descendant_of_test.rb", "test/condition_tests/keywords_test.rb", "test/condition_tests/less_than_or_equal_to_test.rb", "test/condition_tests/less_than_test.rb", "test/condition_tests/like_test.rb", "test/condition_tests/nil_test.rb", "test/condition_tests/not_begin_with_test.rb", "test/condition_tests/not_blank_test.rb", "test/condition_tests/not_end_with_test.rb", "test/condition_tests/not_equal_test.rb", "test/condition_tests/not_have_keywords_test.rb", "test/condition_tests/not_like_test.rb", "test/condition_tests/not_nil_test.rb", "test/condition_tests/sibling_of_test.rb", "test/conditions_tests/any_or_all_test.rb", "test/conditions_tests/base_test.rb", "test/conditions_tests/groups_test.rb", "test/conditions_tests/magic_methods_test.rb", "test/conditions_tests/multiparameter_attributes_test.rb", "test/conditions_tests/protection_test.rb", "test/config_test.rb", "test/fixtures/accounts.yml", "test/fixtures/animals.yml", "test/fixtures/orders.yml", "test/fixtures/user_groups.yml", "test/fixtures/users.yml", "test/libs/awesome_nested_set/compatability.rb", "test/libs/awesome_nested_set/helper.rb", "test/libs/awesome_nested_set/named_scope.rb", "test/libs/awesome_nested_set.rb", "test/libs/rexml_fix.rb", "test/modifier_tests/day_of_month_test.rb", "test/search_tests/base_test.rb", "test/search_tests/conditions_test.rb", "test/search_tests/ordering_test.rb", "test/search_tests/pagination_test.rb", "test/search_tests/protection_test.rb", "test/test_helper.rb", "TODO.rdoc", "searchlogic.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/binarylogic/searchlogic}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Searchlogic", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{searchlogic}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Object based ActiveRecord searching, ordering, pagination, and more!}
  s.test_files = ["test/active_record_tests/associations_test.rb", "test/active_record_tests/base_test.rb", "test/condition_tests/base_test.rb", "test/condition_tests/begins_with_test.rb", "test/condition_tests/blank_test.rb", "test/condition_tests/child_of_test.rb", "test/condition_tests/descendant_of_test.rb", "test/condition_tests/ends_with_test.rb", "test/condition_tests/equals_test.rb", "test/condition_tests/greater_than_or_equal_to_test.rb", "test/condition_tests/greater_than_test.rb", "test/condition_tests/inclusive_descendant_of_test.rb", "test/condition_tests/keywords_test.rb", "test/condition_tests/less_than_or_equal_to_test.rb", "test/condition_tests/less_than_test.rb", "test/condition_tests/like_test.rb", "test/condition_tests/nil_test.rb", "test/condition_tests/not_begin_with_test.rb", "test/condition_tests/not_blank_test.rb", "test/condition_tests/not_end_with_test.rb", "test/condition_tests/not_equal_test.rb", "test/condition_tests/not_have_keywords_test.rb", "test/condition_tests/not_like_test.rb", "test/condition_tests/not_nil_test.rb", "test/condition_tests/sibling_of_test.rb", "test/conditions_tests/any_or_all_test.rb", "test/conditions_tests/base_test.rb", "test/conditions_tests/groups_test.rb", "test/conditions_tests/magic_methods_test.rb", "test/conditions_tests/multiparameter_attributes_test.rb", "test/conditions_tests/protection_test.rb", "test/config_test.rb", "test/modifier_tests/day_of_month_test.rb", "test/search_tests/base_test.rb", "test/search_tests/conditions_test.rb", "test/search_tests/ordering_test.rb", "test/search_tests/pagination_test.rb", "test/search_tests/protection_test.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_runtime_dependency(%q<echoe>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<echoe>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<echoe>, [">= 0"])
  end
end
