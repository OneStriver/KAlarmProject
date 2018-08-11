package com.fh.alarmProcess.observerPattern;

import com.fh.alarmProcess.alarmMsgPojo.AlarmProcessPOJO;
import com.fh.mqtt.MqttMessageServer;

/**
 * 发送给MQTT的消息
 */
public class AlarmToMqttDispaly {
	
	public AlarmToMqttDispaly() {
		
	}

	// 发送消息到MQTT
	public void sendMsgToMqtt(AlarmProcessPOJO alarmProcessPOJO) {
		//
		String sendTarget = alarmProcessPOJO.getTarget();
		String sendTopicStr = "/alarm/"+alarmProcessPOJO.getEquipName();
		if("".equals(sendTarget) || (sendTarget==null)){
			sendTopicStr = sendTopicStr+
					"/"+alarmProcessPOJO.getCode()+
					"/"+alarmProcessPOJO.getSource();
		}else{
			sendTopicStr = sendTopicStr+
					"/"+alarmProcessPOJO.getCode()+
					"/"+sendTarget+
					"/"+alarmProcessPOJO.getSource();
		}
		System.err.println(">>>>>>>>>>>>>>>>>>>>>>推送的主题:"+sendTopicStr);
		MqttMessageServer.getInstance().send(alarmProcessPOJO.getAddition_pairs(), 0,sendTopicStr);
		System.err.println(">>>>>>>>>>>>>>>>>>>>>>推送告警消息完成>>>>>>>>>>>>>>>>>>");
		
	}
	
	//发送消息给前台提示(WebSocket连接)
	/*
	String message = "告警序号:"+almMqttPOJO.getNo()+"<br/>"+
					"设备名称:"+almMqttPOJO.getEquipName()+"<br/>"+
					"告警类型:"+(String)almType+"<br/>"+
					"告警级别:"+(String)almSeverity+"<br/>"+
					"告警原因:"+almMqttPOJO.getCause()+"<br/>"+
					"发生时间:"+almMqttPOJO.getRaised_time();	
	RealTimeAlarmMessageServer.sendMqttMessage(message);
	*/
}
