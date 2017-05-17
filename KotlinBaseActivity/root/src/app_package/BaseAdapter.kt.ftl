package ${applicationPackage}.base

import android.content.Context
import android.support.v7.widget.RecyclerView
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import org.jetbrains.anko.*

abstract class BaseAdapter<T>(private var isFooter: Boolean = false,
                              private var isEmpty: Boolean = false,
                              private var isMore: Boolean = false,
                              private val mData: MutableList<T> = mutableListOf<T>())
    : RecyclerView.Adapter<ViewHolder>() {

    protected var mContext: Context? = null
    private val FOOTER = 50
    private val EMPTY = 51
    private val MORE = 52
    private val DEFAULT = 0
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        if (mContext == null) mContext = parent.context
        when (viewType) {
            FOOTER -> return ViewHolder(footerView(mContext!!))
            EMPTY -> return ViewHolder(emptyView(mContext!!))
            MORE -> return ViewHolder(moreView(mContext!!))
            DEFAULT -> return ViewHolder(convertView(mContext!!))
            else -> return ViewHolder(convertView(mContext!!))
        }
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        when (holder.itemViewType) {
            FOOTER -> footer(holder)
            EMPTY -> empty(holder)
            MORE -> more(holder)
            DEFAULT -> convert(holder, mData[position])
            else -> convert(holder, mData[position])
        }
    }

    abstract fun convert(holder: ViewHolder, item: T)
    abstract fun convertView(context: Context): View
    open fun footer(holder: ViewHolder) {
        holder.setText(0x1205d, "我们是有底线的")
    }

    open fun footerView(context: Context): View = with(context) {
        verticalLayout {
            lparams(matchParent, dip(50))
            textView("其他登录") {
                id = 0x1205d
                gravity = Gravity.CENTER
                lines = 1
                textSize = 15f
                textColor = 0xff666666.toInt()
                backgroundColor = 0xffe6e6e6.toInt()
            }.lparams(matchParent, matchParent)
        }
    }

    open fun empty(holder: ViewHolder) {

    }

    open fun emptyView(context: Context): View = with(context) {
        linearLayout {

        }
    }

    open fun more(holder: ViewHolder) {
        holder.setText(0x1205e, "加载更多内容")
        loadMore(holder)
    }

    open fun loadMore(holder: ViewHolder) {

    }

    open fun moreView(context: Context): View = with(context) {
        verticalLayout {
            lparams(matchParent, dip(50))
            textView {
                id = 0x1205e
                gravity = Gravity.CENTER
                lines = 1
                textSize = 15f
                textColor = 0xff666666.toInt()
                backgroundColor = 0xffe6e6e6.toInt()
            }.lparams(matchParent, matchParent)
        }
    }

    override fun getItemViewType(position: Int): Int {
        if (isEmpty && mData.isEmpty()) return EMPTY
        if (isMore && position == itemCount - 1) return MORE
        if (isFooter && position == itemCount - 1) return FOOTER
        return DEFAULT
    }

    override fun getItemCount(): Int {
        return mData.size +
                if ((isFooter || isMore) && mData.isNotEmpty()) 1 else 0 +
                        if (isEmpty && mData.isEmpty()) 1 else 0
    }

    fun getDateCount() = mData.size
    fun setFooter(footer: Boolean) {
        isFooter = footer
    }

    fun setEmpty(empty: Boolean) {
        isEmpty = empty
    }

    fun setMore(more: Boolean) {
        isMore = more
    }

    /**
     * @param data 添加数据
     */
    fun setData(data: List<T>?) {
        clear()
        data?.let {
            mData.addAll(it)
            notifyItemRangeInserted(0, mData.size)
        }
    }

    /**
     * @param data 添加数据
     */
    fun addData(data: List<T>?) {
        data?.let {
            if (it.isEmpty()) {
                return
            }
            val count = mData.size
            mData.addAll(it)
            notifyItemRangeInserted(count, it.size)
        }
    }

    /**
     * @param data 添加数据
     */
    fun addData(data: T?) {
        data?.let {
            val count = mData.size
            mData.add(it)
            notifyItemInserted(count)
        }
    }

    /**
     * @param data 添加数据
     */
    fun addData(data: List<T>?, position: Int) {
        data?.let {
            if (it.isEmpty()) {
                return
            }
            mData.addAll(it)
            notifyItemRangeInserted(position, it.size)
        }
    }

    /**
     * @param data 添加数据
     */
    fun addData(data: T?, position: Int) {
        data?.let {
            mData.add(position, it)
            notifyItemInserted(position)
        }
    }

    /**
     * 清空适配器数据
     */
    fun clear() {
        mData.clear()
        notifyDataSetChanged()
    }

    /**
     * @param position 删除角标为position的数据
     */
    fun remove(position: Int) {
        mData.removeAt(position)
        notifyItemRemoved(position)
    }

    /**
     * @param data 删除指定数据
     */
    fun remove(data: T?) {
        data?.let {
            val index = mData.indexOf(it)
            if (index >= 0) remove(index)
        }
    }

    fun getData(): MutableList<T> {
        return mData
    }
}