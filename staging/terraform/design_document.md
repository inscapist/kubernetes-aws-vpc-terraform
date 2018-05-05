## VPC_CIDR: 
```
  10.1.0.0/16   # 1 is singapore
```

## Availability zones: 
```
  ap-southeast-1a
  ap-southeast-1b
  ap-southeast-1c 
```

## CIDR for AZs:
```
  public  -> 10.1.0.0/18
    1a -> 10.1.0.0/20 
    1b -> 10.1.16.0/20
    1c -> 10.1.32.0/20
  private -> 10.0.128.0/18
    1a -> 10.1.128.0/20
    1b -> 10.1.144.0/20 
    1c -> 10.1.160.0/20
 ```

## CIDR for AZs (terraform representation):
```
  1a-public (10.1.0.0/20) => cidrsubnet("10.1.0.0/18", 2, 0) 
  1b-public (10.1.16.0/20) => cidrsubnet("10.1.0.0/18", 2, 1) 
  1c-public (10.1.32.0/20) => cidrsubnet("10.1.0.0/18", 2, 2) 

  1a-private (10.1.128.0/20) => cidrsubnet("10.1.128.0/18", 2, 0) 
  1b-private (10.1.144.0/20 ) => cidrsubnet("10.1.128.0/18", 2, 1) 
  1c-private (10.1.160.0/20) => cidrsubnet("10.1.128.0/18", 2, 2) 
```

Systematic Terraform Calculation:
https://www.terraform.io/docs/providers/aws/d/availability_zone.html
