package com.jusung.web.dto;

public class BoardDTO {
	private int board_no, board_count, commemt;
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public int getBoard_count() {
		return board_count;
	}
	public void setBoard_count(int board_count) {
		this.board_count = board_count;
	}
	public int getCommemt() {
		return commemt;
	}
	public void setCommemt(int commemt) {
		this.commemt = commemt;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_write() {
		return board_write;
	}
	public void setBoard_write(String board_write) {
		this.board_write = board_write;
	}
	public String getBoard_date() {
		return board_date;
	}
	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}
	private String board_title, board_write, board_date;
}
