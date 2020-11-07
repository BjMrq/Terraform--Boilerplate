## Set variables

- Look at the required variable from exemple.init.config
- Create ```init.config```
- Edit init.config accordingly
- Create ```terraform.tfvars```
- Add variables used in ```variables.tf``` in ```terraform.tfvars```


## Init 

```
terraform init -backend-config="init.config" 
```

## Plan 

```
terraform plan" 
```


## Apply 

```
terraform apply 
```

## Build
In your application run the appropriate build command 

## Deploy 
Deploy the builded application in s3
```
aws s3 sync build s3://${your-bucket-name}
```

## Second environnement
Since the relevant variables are exported from ```backend.tf``` you can deploy an other environnement with
```
terraform init \
  -backend-config "bucket=$TF_VAR_stateBucket" \
  -backend-config "region=$TF_VAR_region" \
  -backend-config "key=terraform-state/$TF_VAR_appName/$TF_VAR_environment"
```