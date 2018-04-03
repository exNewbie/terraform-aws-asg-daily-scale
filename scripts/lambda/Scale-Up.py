import boto3

def lambda_handler(event, context):
    ssm = boto3.client('ssm')
    autoscaling = boto3.client('autoscaling')
    
    asg_param_name = event['ParamStore-Name']
    asg_filters = event['ASG-Name']
    
    try:
        asg_param = ssm.get_parameter( Name=asg_param_name )

    except:
        print "Name=" + asg_param_name + " throw exceptions"
        exit()

    stored_params = str(asg_param['Parameter']['Value']).split(', ') #MinSize:1, MaxSize: 1, DesiredCapacity: 1
    MinSize = int(stored_params[0].split(':')[1]) #MinSize:1
    MaxSize = int(stored_params[1].split(':')[1])
    DesiredCapacity = int(stored_params[2].split(':')[1])

    scale_up = autoscaling.update_auto_scaling_group( AutoScalingGroupName=asg_filters, MinSize=MinSize, MaxSize=MaxSize, DesiredCapacity=DesiredCapacity)
    return scale_up
