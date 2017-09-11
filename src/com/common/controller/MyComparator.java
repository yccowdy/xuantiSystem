package com.common.controller;

import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.text.CollationKey;
import java.text.Collator;
import java.util.Comparator;

public class MyComparator implements Comparator{

	String attiName=null;

	@Override
	public int compare(Object obj1, Object obj2) {
		// TODO Auto-generated method stub
		if(attiName==null){
			//不比较
			return 2;
		}else{
			if(compareField(obj1,obj2,attiName)>0)
			{//如果obj1的属性值大于obj2的属性值，则返回正数
				return 1;
			}else if(compareField(obj1,obj2,attiName)<0){
				return -1;
			}
		}
		return 0;
	}


	//通过attiName的值来获取ArrayList中一个对象对应的那个属性值
	private static Object getAttiValueByName(String attiName,Object obj)
	{
		try{
			String Letter = attiName.substring(0,1).toUpperCase();
			String methodStr = "get"+Letter+attiName.substring(1);
			Method method = obj.getClass().getMethod(methodStr, new Class[]{});

			Object value = method.invoke(obj, new Object[]{});

			return value;
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("------------------------------------------------------");
			System.out.println("---------该"+attiName+"属性不存在----------------------");
			System.out.println("------------------------------------------------------");
			return null;
		}
	}

	/**
	 * @param fieldName
	 * 根据属性名排序
	 * */
	private static int compareField(Object obj1,Object obj2,String attiName){
		try{
			Object value1 = getAttiValueByName(attiName,obj1);
			Object value2 = getAttiValueByName(attiName,obj2);

			//--字符串比较
			if(value1 instanceof String){
				String v1 = getAttiValueByName(attiName,obj1).toString();
				String v2 = getAttiValueByName(attiName,obj2).toString();
				Collator myCollator = Collator.getInstance();
				CollationKey[] keys = new CollationKey[5];
				keys[0] = myCollator.getCollationKey(v1);
				keys[1] = myCollator.getCollationKey(v2);
				return (keys[0].compareTo(keys[1]));
			}else if("java.lang.Boolean".equals(value1.getClass().getName()) || "java.lang.Byte".equals(value1.getClass().getName())){
				//--非比较属性不比较
				return 0;
			}else{
				BigDecimal b1 = new BigDecimal(value1.toString());
				BigDecimal b2 = new BigDecimal(value2.toString());
				return b1.compareTo(b2);
			}
		} catch (Exception e)
		{
			System.out.println("-----------------------------------------------------------------------------");
			System.out.println("---------对象的该属性不存在或者不允许在此安全级别上反射该属性，详情请查阅JAVA DOC--------");
			System.out.println("-----------------------------------------------------------------------------");
			e.printStackTrace();
		}
		//小于
		return -1;
	}

	public String getAttiName() {
		return attiName;
	}

	public void setAttiName(String attiName) {
		this.attiName = attiName;
	}
}
