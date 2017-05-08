<?xml version="1.0"?>
<recipe>

    <#include "../common/recipe_manifest.xml.ftl" />


    <instantiate from="root/src/app_package/MainActivity.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/${activityClass}.kt" />
	<instantiate from="root/src/app_package/MainComponent.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/${componentClass}.kt" />

   
    <open file="${escapeXmlAttribute(srcOut)}/${activityClass}.kt" />
    <open file="${escapeXmlAttribute(srcOut)}/${componentClass}.kt" />

</recipe>
