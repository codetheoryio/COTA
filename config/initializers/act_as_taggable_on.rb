# For MySql users, You can circumvent at any time the problem of special characters issue 623 by setting in an initializer file
ActsAsTaggableOn.force_binary_collation = true

# If you would like tags to be case-sensitive and not use LIKE queries for creation
ActsAsTaggableOn.strict_case_match = true