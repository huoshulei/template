package ${packageName};

import ${applicationPackage}.base.BaseActivity
import org.jetbrains.anko.*
/**
 * 创建者：
 * 时间：  
 */
class ${activityClass}(override val component: ${componentClass} = ${componentClass}()) 
    : BaseActivity<${activityClass}, ${componentClass}>() {

	 override fun configView() {
		component.titleText?.textResource = R.string.title_${activityToLayout(activityClass)}
      
    }
}