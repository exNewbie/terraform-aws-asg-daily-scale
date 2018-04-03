import boto3

def lambda_handler(event, context):
    ssm = boto3.client('ssm')
    autoscaling = boto3.client('autoscaling')
    
    asg_param_name = event['ParamStore-Name']
    asg_filters = event['ASG-Name']
    
    try:
        arr_asg = autoscaling.describe_auto_scaling_groups( AutoScalingGroupNames=[asg_filters])
    except:
        print("AutoScalingGroupNames=asg_filters does not exist")
    
    #Build Parameter Store
    new_asg_param = 'MinSize:' + str(arr_asg['AutoScalingGroups'][0]['MinSize']) + ', MaxSize: ' + str(arr_asg['AutoScalingGroups'][0]['MaxSize']) + ', DesiredCapacity: ' + str(arr_asg['AutoScalingGroups'][0]['DesiredCapacity'])
    
    #Update Parameter Store
    print(ssm.put_parameter( Name=asg_param_name, Value=new_asg_param, Type='StringList', Overwrite=True ))
    
    scale_down = autoscaling.update_auto_scaling_group( AutoScalingGroupName=asg_filters, MinSize=0, MaxSize=0, DesiredCapacity=0)
    return scale_down
