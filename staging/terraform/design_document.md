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
  1a -> 10.1.0.0/18
    public  -> 10.1.0.0/20
    private -> 10.1.16.0/20
  1b -> 10.1.64.0/18 
    public  -> 10.1.64.0/20
    private -> 10.1.80.0/20
  1c -> 10.1.128.0/18 
    public  -> 10.1.128.0/20
    private -> 10.1.144.0/20
```

Results:
65534 per VPC
16382 per region
4094 per subnet