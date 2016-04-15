package com.lsgx.admin.model.vo;

import com.lsgx.admin.constants.SystemConstants;
import com.lsgx.admin.model.Article;
import com.lsgx.admin.model.Usertest;
import com.lsgx.admin.util.StringUtil;

import java.util.Date;

public class ArticleVO extends Article
{
    /**
     * 
     */
    private static final long serialVersionUID = -6491208713201529858L;

    public final static int PAGE_SHOW_COUNT = 20;
    /**
     * �����б������ʾͼƬ��
     */
    private String url;

    private String realUrl;
    
    private int pageNum = 1;
    
    private int numPerPage = 0;
    
    private String orderField;
    
    private String orderDirection;
    
    private Date startDate;
    
    private Date endDate;
    
    public int getPageNum()
    {
        return pageNum;
    }
    
    public void setPageNum(int pageNum)
    {
        this.pageNum = pageNum;
    }
    
    public int getNumPerPage()
    {
        return numPerPage > 0 ? numPerPage : PAGE_SHOW_COUNT;
    }
    
    public void setNumPerPage(int numPerPage)
    {
        this.numPerPage = numPerPage;
    }
    
    public String getOrderField()
    {
        return orderField;
    }
    
    public void setOrderField(String orderField)
    {
        this.orderField = orderField;
    }
    
    public String getOrderDirection()
    {
        return orderDirection;
    }
    
    public void setOrderDirection(String orderDirection)
    {
        this.orderDirection = orderDirection;
    }
    
    public Date getStartDate()
    {
        return startDate;
    }
    
    public void setStartDate(Date startDate)
    {
        this.startDate = startDate;
    }
    
    public Date getEndDate()
    {
        return endDate;
    }
    
    public void setEndDate(Date endDate)
    {
        this.endDate = endDate;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getRealUrl() {
        if (StringUtil.isNotEmpty(url)) {
            return SystemConstants.Img_real_path+url;
        }else{
            return "";
        }
    }

    public boolean isZqkm(){
        return SystemConstants.Article_zqkm.equals(this.getCategory());
    }

    public boolean isLsqt(){
        return SystemConstants.Article_lsqt.equals(this.getCategory());
    }

    public boolean isZrfp(){
        return SystemConstants.Article_zrfp.equals(this.getCategory());
    }
}
