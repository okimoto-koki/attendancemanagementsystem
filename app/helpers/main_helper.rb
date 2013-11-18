#encoding: utf-8
module MainHelper
	def main_table
		"<table border='1'>
		<thead>
			<tr>
				<th>名前</th>
				<th>学生番号</th>
				<th>登録時間</th>
				<th>遅刻判定</th>
			</tr>
		</thead>
		<br>
		<tbody>
		<% @#{array}.each do |userinfo| %>
		<tr>
 			<td><%= userinfo.name %></td>
 			<td><%= userinfo.number%></td>
 			<td><%= userinfo.time.strftime('%Y年%m月%d日 %H時%M分%S秒')%></td>
 			<td><%= userinfo.check %></td>
 		</tr>
		<% end %>
		</tbody>
		</table>"
	end
end