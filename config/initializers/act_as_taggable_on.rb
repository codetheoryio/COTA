# For MySql users, You can circumvent at any time the problem of special characters issue 623 by setting in an initializer file
ActsAsTaggableOn.force_binary_collation = true

#force all tags to be saved as lowercase
ActsAsTaggableOn.force_lowercase = true