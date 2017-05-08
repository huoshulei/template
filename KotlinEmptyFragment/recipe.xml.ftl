<?xml version="1.0"?>
<recipe>

    <instantiate from="root/src/app_package/MainFragment.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/${className}.kt" />
	<instantiate from="root/src/app_package/MainComponent.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/${componentClass}.kt" />

   
    <open file="${escapeXmlAttribute(srcOut)}/${className}.kt" />
    <open file="${escapeXmlAttribute(srcOut)}/${componentClass}.kt" />
</recipe>
