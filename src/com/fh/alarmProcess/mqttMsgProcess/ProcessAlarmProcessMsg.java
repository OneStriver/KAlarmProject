package com.fh.alarmProcess.mqttMsgProcess;

import java.util.Iterator;
import java.util.List;

import com.fh.alarmProcess.alarmMsgPojo.AlarmOriginalPOJO;
import com.fh.alarmProcess.alarmMsgPojo.AlarmProcessPOJO;
import com.fh.alarmProcess.message.GlobalHashMap;
import com.fh.alarmProcess.observerPattern.AlarmObserverStored;
import com.fh.alarmProcess.quartzConfig.HandleTaskJob;
import com.fh.alarmProcess.quartzConfig.QuartzManager;
import com.fh.entity.alarmAttr.AlarmAttributeEntity;
import com.fh.readProperty.PropertyReadUtil;
import com.fh.util.TimeUtil;

import net.sf.json.JSONObject;

/**
 * 开始处理接收的消息并通知订阅者
 */
public class ProcessAlarmProcessMsg {

	private AlarmOriginalPOJO alarmOriginalPOJO;
	private AlarmProcessPOJO alarmProcessPOJO;
	private AlarmAttributeEntity alarmAttributeEntity;
	
	public ProcessAlarmProcessMsg() {
		
	}

	/**
	 * 处理MQTT接收消息的方法
	 */
	public void processAlarm(String topic,String info) {
		try {
			alarmOriginalPOJO = new AlarmOriginalPOJO();
			alarmProcessPOJO = new AlarmProcessPOJO();
			//告警源
			String[] splitTopic = topic.split("/");
			// /raw_alarm/ATCA/9527/board/9527
			String alarmResourceStr = topic.substring(1+splitTopic[1].length()+1,topic.length());
			alarmProcessPOJO.setSource(alarmResourceStr);
			//设备名称
			alarmProcessPOJO.setEquipName(splitTopic[2]);
			
			JSONObject obj = JSONObject.fromObject(info);
			Iterator<?> it = obj.keys();
			while (it.hasNext()) {
				Object key = it.next();
				Object value = obj.get(key);
				if ("code".equals(key)) {
					alarmOriginalPOJO.setCode(value.toString());
				}
				if ("clear".equals(key)) {
					alarmOriginalPOJO.setClear(value.toString());
				}
				//附加信息(addition‐pairs)
				if ("addition_pairs".equals(key)) {
					alarmOriginalPOJO.setAddition_pairs(value.toString());
				}
			}
			if(alarmOriginalPOJO.getCode() == null || alarmOriginalPOJO.getClear() == null || alarmOriginalPOJO.getAddition_pairs() == null){
				return;
			}
			
			String deviceNameStr = splitTopic[2];
			//查询数据库的告警的属性信息
			List<AlarmAttributeEntity> alarmAttributeList = GlobalHashMap.alarmAttributeMap.get("alarmAttributeList");
			for (int i = 0; i < alarmAttributeList.size(); i++) {
				AlarmAttributeEntity eachAlarmAttribute = alarmAttributeList.get(i);
				if((Integer.valueOf(alarmOriginalPOJO.getCode()) == eachAlarmAttribute.getAlarmCode())
					&& (deviceNameStr.equals(eachAlarmAttribute.getDeviceType()))){
					alarmAttributeEntity = eachAlarmAttribute;
					break;
				}
			}
			//获取项目名称
			String projectName = PropertyReadUtil.getInstance().getProjectName();
			//告警码
			alarmProcessPOJO.setCode(Integer.valueOf(alarmOriginalPOJO.getCode()));
			//告警类型
			alarmProcessPOJO.setAlarmType(""+alarmAttributeEntity.getAlarmType());
			//告警等级
			alarmProcessPOJO.setSeverity(""+alarmAttributeEntity.getAlarmSeverity());
			//告警描述
			alarmProcessPOJO.setDesc(alarmAttributeEntity.getAlarmDescription());
			//告警原因
			alarmProcessPOJO.setCause(alarmAttributeEntity.getAlarmCause());
			//建议处理措施
			alarmProcessPOJO.setTreatment(alarmAttributeEntity.getTreatment());
			//告警发生时间
			alarmProcessPOJO.setRaised_time(TimeUtil.getNowTime());
			//附加信息(原始数据)
			alarmProcessPOJO.setAddition_pairs(alarmOriginalPOJO.getAddition_pairs());
			//上报消息提示是否清除(原始数据)
			alarmProcessPOJO.setClear(alarmOriginalPOJO.getClear());
			// 51/1/board/1:2(由source和code两个字段组成)
			String alarmSingleFlag = topic.substring(1+splitTopic[1].length()+1,topic.length()) + ":" + alarmOriginalPOJO.getCode();
			//判断原始消息是否需要清除
			if("1510".equals(projectName)){
				if ("true".equals(alarmOriginalPOJO.getClear())) {
					alarmProcessPOJO.setCleared_time(TimeUtil.getNowTime());
					//设备自动上报告警清除消息
					alarmProcessPOJO.setCleared_user("无");
					//缓存中有数据说明上报过该告警(首先清除任务,然后删除缓存)
					QuartzManager.removeJob(GlobalHashMap.getJobName(alarmSingleFlag),
							GlobalHashMap.getJobGroupName(alarmSingleFlag), GlobalHashMap.getTriggerName(alarmSingleFlag),
							GlobalHashMap.getTriggerGroupName(alarmSingleFlag));
				}else if ("false".equals(alarmOriginalPOJO.getClear())) {
					//缓存中有数据说明上报过该告警
					QuartzManager.removeJob(GlobalHashMap.getJobName(alarmSingleFlag),
							GlobalHashMap.getJobGroupName(alarmSingleFlag),
							GlobalHashMap.getTriggerName(alarmSingleFlag),
							GlobalHashMap.getTriggerGroupName(alarmSingleFlag));
					
					QuartzManager.addJob(GlobalHashMap.getJobName(alarmSingleFlag),
							GlobalHashMap.getJobGroupName(alarmSingleFlag), GlobalHashMap.getTriggerName(alarmSingleFlag),
							GlobalHashMap.getTriggerGroupName(alarmSingleFlag), HandleTaskJob.class, 30, alarmProcessPOJO);
				}
			}
			AlarmObserverStored alarmObserverStored = new AlarmObserverStored();
			alarmObserverStored.processMqttMessage(alarmProcessPOJO);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
