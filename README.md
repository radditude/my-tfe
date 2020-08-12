# my-tfe

This configuration will produce a whole mess of organizations, teams, and users. Each user created will be invited to each organization and added to every team in every organization.

Note that you'll need to manually accept the invitation in order to actually use any of the user accounts created.

## How to use

```
cp terraform.tfvars.example terraform.tfvars
```

Fill in the variable values with your TFE token and some base data. Then run `terraform plan` to see what will be created.

Once you've adjusted things to your satisfaction, run `terraform apply` to make it happen.
