package com.ax.subject.model;
import java.util.*;
import java.text.*;
public class paixu {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	    String[] a1 = {"保定","何子安","于小云","刘帝","刘何保定子安","刘","刘娜","家强","刘博"}; 
        getSortOfChinese(a1);
        for (int i = 0; i < a1.length; i++) {
            System.out.println(a1[i]);
        }
	}
        public static String[] getSortOfChinese(String[] a) {
            // Collator 类是用来执行区分语言环境这里使用CHINA
            Comparator cmp = Collator.getInstance(java.util.Locale.CHINA);

            // JDKz自带对数组进行排序。
            Arrays.sort(a, cmp);
            return a;
        }

}
