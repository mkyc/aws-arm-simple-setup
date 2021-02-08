resource "aws_key_pair" "kp" {
  key_name_prefix = "${var.name}-kp"
  public_key      = file(var.rsa_pub_path)
  tags            = {
    Name           = "${var.name}-kp"
    resource_group = var.name
    creator        = var.creator
  }
}

resource "aws_resourcegroups_group" "rg" {
  name = "${var.name}-rg"

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": [
    "AWS::EC2::Subnet",
    "AWS::EC2::VPC",
    "AWS::EC2::InternetGateway",
    "AWS::EC2::NatGateway",
    "AWS::EC2::SecurityGroup",
    "AWS::EC2::Instance",
    "AWS::EC2::RouteTable",
    "AWS::EC2::EIP"
  ],
  "TagFilters": [
    {
      "Key": "resource_group",
      "Values": ["${var.name}"]
    }
  ]
}
JSON
  }

  tags = {
    Name           = "${var.name}-rg"
    resource_group = var.name
    creator = var.creator
  }
}

resource "aws_instance" "vm" {
  ami           = var.ami
  instance_type = var.vm_size
  subnet_id     = aws_subnet.subnet.id

  key_name = aws_key_pair.kp.key_name

  security_groups = [
    aws_security_group.sg.id]

  root_block_device {
    volume_size = var.root_volume_size
  }

  tags = {
    Name           = "${var.name}-vm"
    resource_group = var.name
    creator = var.creator
  }
}
