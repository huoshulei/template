<?xml version="1.0"?>
<recipe>
	<dependency mavenUrl="com.android.support:support-vector-drawable:${buildApi}.+" />
   
    <merge from="root/build.gradle"
             to="${escapeXmlAttribute(projectOut)}/build.gradle" />


    <instantiate from="root/src/app_package/BaseActivity.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/base/BaseActivity.kt" />
	<instantiate from="root/src/app_package/BaseAdapter.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/base/BaseAdapter.kt" />
	<instantiate from="root/src/app_package/BaseComponent.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/base/BaseComponent.kt" />
    <instantiate from="root/src/app_package/BaseFragment.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/base/BaseFragment.kt" />
	<instantiate from="root/src/app_package/BaseFragmentComponent.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/base/BaseFragmentComponent.kt" />
	<instantiate from="root/src/app_package/BasePresenter.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/base/BasePresenter.kt" /> 
	<instantiate from="root/src/app_package/LifeActivity.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/base/LifeActivity.kt" />
	<instantiate from="root/src/app_package/LifeFragment.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/base/LifeFragment.kt" />
	<instantiate from="root/src/app_package/OnProgress.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/base/OnProgress.kt" />
	<instantiate from="root/src/app_package/ViewHolder.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/base/ViewHolder.kt" />
				
	<instantiate from="root/src/net/ApiException.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/net/ApiException.kt" />
	<instantiate from="root/src/net/ApiService.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/net/ApiService.kt" />
	<instantiate from="root/src/net/Re.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/net/Re.kt" />
	<instantiate from="root/src/net/ServeException.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/net/ServeException.kt" />
	<instantiate from="root/src/net/TokenException.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/net/TokenException.kt" />
				
	<instantiate from="root/src/utlis/log/HttpLoggingInterceptor.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/utlis/log/HttpLoggingInterceptor.kt" />
	<instantiate from="root/src/utlis/log/L.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/utlis/log/L.kt" />
   
   <instantiate from="root/src/widget/SwipeBackLayout.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/widget/SwipeBackLayout.kt" />
   
   
    <open file="${escapeXmlAttribute(srcOut)}/base/BaseActivity.kt" />
    <open file="${escapeXmlAttribute(srcOut)}/base/LifeActivity.kt" />
    <open file="${escapeXmlAttribute(srcOut)}/base/BackActivity.kt" /> 
	<open file="${escapeXmlAttribute(srcOut)}/base/BaseFragment.kt" />
    <open file="${escapeXmlAttribute(srcOut)}/base/BaseAdapter.kt" />
    <open file="${escapeXmlAttribute(srcOut)}/base/BasePresenter.kt" /> 
	<open file="${escapeXmlAttribute(srcOut)}/base/LifeFragment.kt" />
    <open file="${escapeXmlAttribute(srcOut)}/base/ViewHolder.kt" />
    <open file="${escapeXmlAttribute(srcOut)}/base/OnProgress.kt" />
	
	
    <merge from="root/res/values/colors.xml"
             to="${escapeXmlAttribute(resOut)}/values/colors.xml" />
	<copy from="root/res/drawable"
            to="${escapeXmlAttribute(resOut)}/drawable" />
	<copy from="root/res/mipmap-xxhdpi"
            to="${escapeXmlAttribute(resOut)}/mipmap-xxhdpi" />
</recipe>
