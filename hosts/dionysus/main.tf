resource "aws_instance" "dionysus-builder" {
  ami = "ami-01d4a0c2248cbfe38" # nixos-20.09 x86_64
  instance_type = "t2.micro"
  key_name = "hermes"
  security_groups = ["allow_ssh"]
}

resource "aws_key_pair" "builder-keypair" {
  key_name = "hermes"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDrTCobDNloK6IFxp0xSulmWuNSfO3NKcXBjWQQtb30HsXfL7npkYkySs8CqI9QS+WL7w02HT7+S1PqqwyBLLRbnsUTNQF0TTZMd21QGI7KSO6W5AzvIeFpl2I7ejrCOoIIenCw+HZhzrGR3dDtD8oGlAdL/YKPlnNOhrH+BVj0whOAnDefbcR0u9C60J1JBGBX/8kf2toKxXajYy4QoqCDRFLZyx+QuP65aahehoRnJvs75+dSCIwPakB3MSJmx/TIN2wbqMl7MPJ8Azj9QBVNRFgKVUSSaGeia6NDkUxx/bSUQc7mB33nVBCEL6i0XorscHjs34IBynmt/qm+Aia3K+oX3LmlJnpOunnv43yshF0t7vl3B0oZvCzh6QMO9RvGRoIvB0dnC5e+enymQMs7QhBmHTMoA6dt32Mox6ZOaYec6EYqrUy07Mu0wie2yMHxPV9AewbHuZzJITXbVFRcLt6MeYSigrtNfr0JOcf3wUt/xwsS+3O5gxKDLbqKfHc= leo@hermes"
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  description = "Allow inbound SSH traffic"

  ingress {
    description = "SSH traffic"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}
