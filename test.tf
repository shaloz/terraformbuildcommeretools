terraform {
  required_providers {
    commercetools = {
      source  = "labd/commercetools"
      version = "99.0.0"
    }
  }

}

provider "commercetools" {
  client_id     = "VOZBiBLc1jqRONyUQX3MS03I"
  client_secret = "qJmhm_Gr6nGFLOq4v3ZQEJlDgIRVBDKo"
  project_key   = "poc-abbott"
  scopes        = "manage_subscriptions:poc-abbott manage_orders:poc-abbott:the-good-store manage_shopping_lists:poc-abbott:the-good-store manage_api_clients:poc-abbott manage_my_profile:poc-abbott:the-good-store manage_customers:poc-abbott:the-good-store manage_extensions:poc-abbott manage_project:poc-abbott manage_project_settings:poc-abbott manage_my_shopping_lists:poc-abbott:the-good-store manage_my_orders:poc-abbott:the-good-store manage_cart_discounts:poc-abbott:the-good-store manage_types:poc-abbott"
  api_url       = "https://api.us-east-2.aws.commercetools.com"
  token_url     = "https://auth.us-east-2.aws.commercetools.com"
}



//create a custom category with custom fields of different types 
resource "commercetools_type" "my-poc-category" {
  key = "my-poc-category"

  resource_type_ids = ["category"]

  name = {
    en = "abbottCategory"
  }

  description = {
    en = "My Abbott new category"
  }

  field {
    name = "myBoolean"
    label = {
      en = "myBoolean"
    }
    required = false
    type {
      name = "Boolean"
    }
    input_hint = "SingleLine"
  }

  field {
    name = "myNumber"
    label = {
      en = "myNumber"
    }
    required = false
    type {
      name = "Number"
    }
    input_hint = "SingleLine"
  }

  field {
    name = "mySet"

    label = {
      en = "mySet"
    }

    type {
      name = "Set"
      element_type {
        name = "String"
      }
    }
  }

  field {
    name = "myLocalizedString"
    label = {
      en = "myLocalizedString"
    }
    required = false
    type {
      name = "LocalizedString"
    }
    input_hint = "SingleLine"
  }

  field {
    name = "mySetOfLocalizedStrings"
    label = {
      en = "mySetOfLocalizedStrings"
    }
    required = false
    type {
      name = "Set"
      element_type {
        name = "LocalizedString"
      }
    }
    input_hint = "SingleLine"
  }
}


//create a category and map to the custom type created above
resource "commercetools_category" "my-poc-category" {
  name = {
    en = "Abbott Category"
  }
  slug = {
    en = "my-poc-category"
  }

  custom {
    type_id = commercetools_type.my-poc-category.id
    fields = {
      myBoolean = jsonencode(true)
      myNumber  = jsonencode(123)
      mySet     = jsonencode(["a", "b", "c"])
      myLocalizedString = jsonencode({
        en = "English"
      })
      mySetOfLocalizedStrings = jsonencode([
        { en = "English 1" },
        { en = "English 2" }
      ])
    }
  }
}
