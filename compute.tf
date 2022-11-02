//Creating key pair for use of public instance connection
resource "aws_key_pair" "sample-pub-key-ec2" {
    key_name = "sample-pub-key-ec2"
    public_key = file("C:/Users/AnandS9/sample-key-ec2.pub")
  
}



// Creating instances in public subnet to test functionality properply initially
resource "aws_instance" "web-svr-1" {

    //subnet_id = aws_subnet.private-sub-1
    subnet_id = aws_subnet.public-sub-1.id
    instance_type = "t2.micro"
    //associate_public_ip_address = false
    associate_public_ip_address = true
    ami = "ami-0f62d9254ca98e1aa"
    key_name = aws_key_pair.sample-pub-key-ec2.key_name
    ebs_block_device {
        delete_on_termination = true
        volume_size = 1
        volume_type = "gp3"
        device_name = "/dev/sdb"
        
      
    }

    user_data = <<EOF
    #!/bin/sh
    sudo su -
    touch my_cloud_work.txt

    EOF

    

    
  
}