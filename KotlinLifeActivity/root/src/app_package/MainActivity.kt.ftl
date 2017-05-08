package ${packageName};

import ${applicationPackage}.base.LifeActivity

/**
 * 创建者：
 * 时间：  
 */
class ${activityClass}(override val component: ${componentClass} = ${componentClass}()) 
    : LifeActivity<${activityClass},${componentClass}, ${presenterClass}>() {
    override val presenter by lazy { ${presenterClass}(this) }


}