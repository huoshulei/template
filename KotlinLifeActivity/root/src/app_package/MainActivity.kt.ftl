package ${packageName}

import ${applicationPackage}.base.LifeActivity
import ${applicationPackage}.R
import org.jetbrains.anko.*
/**
 * 创建者：
 * 时间：  
 */
class ${activityClass}(override val component: ${componentClass} = ${componentClass}()) 
    : LifeActivity<${activityClass},${componentClass}, ${presenterClass}>() {
    override val presenter by lazy { ${presenterClass}(this) }
	 override fun configView() {
		component.titleText?.textResource = R.string.title_${activityToLayout(activityClass)}
      
    }

}