resource "aws_key_pair" "main"{
  key_name   = "mykeypair"
  ## replace the key with the content from previous command
  ## another good solution is to use the function file("~/.ssh/id_ed25519.pub") 
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICOG4QRs1DDcElbzFvvD1MCiyZVR3AxhEAgAfpbgicsK laborant@flexbox (managed)"
}

resource "aws_security_group" "main" {
  name        = "allow-ssh-and-4444"
  # Fixed description to match the actual port (4444, not 4445)
  description = "Allow SSH and port 4444 from anywhere"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Port 4444 from anywhere"
    from_port   = 4444
    to_port     = 4444
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0     # <--- FIXED (Must be 0 when protocol is -1)
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh-and-4444"
  }
}

resource "aws_instance" "main" {
  ami           = "ami-00d8fc944fb171e29"
  instance_type = "t3.micro"
  key_name = aws_key_pair.main.id

  tags = {
    Name = "HelloWorld"
  }
}
