#!/usr/bin/python
# -*- coding: utf-8 -*-
from PyQt5.QtWidgets import (
    QApplication,
    QMainWindow,
    QMessageBox,
    QDialog,
    QTableWidgetItem,
    QHeaderView,
)

# from .gui import *
import mygui
from PyQt5.QtGui import QIcon, QTextOption
from PyQt5.QtCore import Qt
import pymysql
import sys


import sys, os
from PyQt5.uic import loadUi
from PyQt5.QtWidgets import QApplication, QMainWindow, QDialog, QStackedWidget
from PyQt5 import uic, QtSql

from mygui import Ui_MainWindow


class MainWindow(QMainWindow, Ui_MainWindow):
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)
        icon_dir = os.path.dirname(__file__)#获取当前文件所在目录的路径
        icon_path = os.path.join(icon_dir, "bender.ico")  #根据当前文件所在目录的路径和图标文件名生成图标文件的完整路径
        self.setWindowIcon(QIcon(icon_path))
        self.setupUi(self)

    def create_view(self):
        d_name = self.cs_department.currentText()
        view_name = "cs_student" + str(self.cs_department.currentIndex())
        query = 'select count(*) from information_schema.VIEWS where TABLE_SCHEMA="university" and TABLE_NAME=%s'
        cur.execute(query, [view_name])  # 先查询视图是否已被定义
        if cur.fetchone()[0] == 1:
            QMessageBox.warning(self, "警告", "视图已被定义：" + view_name)
        else:
            query = (
                "create view "
                + view_name
                + ' as select student_num,student_name,class_num from student where class_num in (select class_num from class where department_num in (select department_num from department where college_num="001" and department_name=%s))'
            )
            cur.execute(query, [d_name])
            QMessageBox.information(self, "成功", "成功创建视图：" + view_name)

    def create_index(self):
        index = self.cs_index.currentText().split()[0]
        query = "select count(*) from information_schema.INNODB_INDEXES where NAME=%s"
        cur.execute(query, [index + "_index"])  # 先查询索引是否已被定义
        if cur.fetchone()[0] == 1:
            QMessageBox.warning(self, "警告", "索引已被定义：" + index)
        else:
            query = "create index " + index + "_index on student(" + index + " desc) "
            cur.execute(query)
            QMessageBox.information(self, "成功", "成功创建索引：" + index + "_index")

    def update_s_name_combobox(self):
        self.stu_name_combobox.clear()#清空下拉框中的所有选项
        cur.execute(
            "select student_num, student_name from student order by student_num asc"
        )#执行查询操作，获取学生信息表中所有学生的学号和姓名，并按学号升序排列
        items = [item[0] + " " + item[1] for item in cur.fetchall()] #将查询结果转换为字符串列表，每个元素表示一个学生的学号和姓名，格式为 "学号 姓名"
        self.stu_name_combobox.addItems(items)# 将字符串列表中的所有元素添加到下拉框控件中

    def get_name(self):  # 查询选修课程数大于 x 的学生的姓名（连接查询\Group by\Having）
        #获取界面上输入的选修课程数量，并初始化一个空列表 res 用于存储查询结果
        c_count, res = int(self.sc_stu_count.value()), []
        query = "select student.student_name from student inner join score on student.student_num = score.student_num group by student.student_num HAVING count(*) > %s"
        #设置要执行的SQL语句，用于查询选修课程数大于指定数量的学生姓名
        cur.execute(query, [c_count])#遍历查询结果，并将每个学生的姓名添加到 res 列表中
        for item in cur.fetchall():
            res.append(item[0])
        #生成一条消息字符串，用于告知用户执行的SQL语句及查询条件
        message = """
            select student.student_name
            from student
                inner join score on student.student_num = score.student_num
            group by student.student_num
            HAVING count(*) > {};""".format(
            c_count
        )
        QMessageBox.information(self, "执行的sql语句", message)
        QMessageBox.information(self, "成功", " ".join(res) if len(res) > 0 else "无结果")

    def get_avg_grade(self):  # 查询学生及格科目的平均分（分组+嵌套查询）
        name, res = self.stu_name_combobox.currentText().split()[1], []
        if not name:
            QMessageBox.warning(self, "警告", "请输入姓名")
        else:
            query = "select student_num, avg(grade) from score where student_num in (select student_num from student where student_name = %s)  and grade >= 60 group by student_num"
            cur.execute(query, [name])#遍历查询结果，并将每个学生的学号和平均分添加到 res 列表中
            for item in cur.fetchall():
                res.append(item[0] + "\t" + str(item[1]))
            message = """
                select student_num,
                    avg(grade)
                from score
                where student_num in (
                        select student_num
                        from student
                        where student_name = {}
                    )
                    and grade >= 60
                group by studnet_num""".format(
                name
            )
            QMessageBox.information(self, "执行的sql语句", message)
            QMessageBox.information(
                self, "成功", "\n".join(res) if len(res) != 0 else "无结果"
            )

    def stu_insert(self):  # 新建学生信息
        num, name, c_num = (
            self.stu_num.text(),
            self.stu_name.text(),
            self.class_num.text(),
        )#获取界面上输入的学生信息，包括学号、姓名和班号
        if not num or not name or not c_num:
            QMessageBox.warning(self, "警告", "请输入学号、姓名与班号")
        elif (#判断格式是否正确
            not num.isdigit()
            or len(num) != 10
            or not c_num.isdigit()
            or len(c_num) != 3
        ):
            QMessageBox.warning(self, "警告", "学号为10位数字，班号为3位数字")
        else:#设置要执行的SQL语句，用于查询是否已存在相同学号的学生
            query = "select * from student where student_num=%s"
            if cur.execute(query, [num]):
                QMessageBox.warning(self, "插入异常", "该学号已存在，请重新输入")
            elif not cur.execute("select * from class where class_num=%s", [c_num]):
                QMessageBox.warning(self, "插入异常", "该班号在班级表中不存在，请尝试在班级表中插入对应条目")
            else:
                QMessageBox.information(self, "成功", "成功插入一条学生数据")
                query = "insert into student(student_num, student_name, class_num) values (%s,%s,%s)"
                cur.execute(query, [num, name, c_num])
                con.commit()  # 修改数据时，需要commit操作
                self.update_s_name_combobox()

    def stu_delete(self):  # 删除学生信息
        num = self.stu_num.text()#获取界面上输入的学生学号
        if not num:#判断输入的学号是否为空，如果为空，则弹出提示窗口并提醒用户输入学号
            QMessageBox.warning(self, "警告", "学号为空")
        elif not num.isdigit() or len(num) != 10:
            QMessageBox.warning(self, "警告", "学号只可为10位数字")
        else:
            query = "select * from student where student_num=%s"
            if not cur.execute(query, [num]):#执行查询操作，并判断查询结果是否为空。如果为空，则说明该学号不存在，弹出提示窗口并提示用户重新输入
                QMessageBox.warning(self, "删除异常", "该学号不存在，请重新输入")
            elif cur.execute("select * from score where student_num =%s", [num]):
                QMessageBox.warning(self, "删除异常", "该学号正被选课表作为外键引用，请尝试删除对应条目")
            else:#如果待删除的学生存在且未被选课表引用，则弹出提示窗口显示删除成功，并执行删除操作
                if cur.execute("select * from score where student_num =%s", [num]):
                    QMessageBox.information(self, "提示", "该学号正被选课表作为外键引用，触发器已默认删除对应条目数据")
                QMessageBox.information(self, "成功", "成功删除一条学生数据")
                query = "delete from student where student_num=%s"#设置要执行的SQL语句，用于将该学生信息从学生表中删除
                cur.execute(query, [num])#执行删除操作，并将学号作为参数传递给删除语句
                con.commit()  # 修改数据时，需要commit操作
                self.update_s_name_combobox()#更新界面上学生姓名下拉框的选项，以反映最新的学生信息

    def course_insert(self):  # 新建课程信息
        num, name, t_num = (
            self.course_num.text(),
            self.course_name.text(),
            self.teacher_num.text(),
        )
        if not num or not name or not t_num:
            QMessageBox.warning(self, "警告", "请输入课程号、课程名和任课教师号")
        elif not num.isdigit() or len(num) != 3 or not num.isdigit() or len(t_num) != 5:
            QMessageBox.warning(self, "警告", "课程号为3位数字，教师号为5位数字")
        else:
            query = "select * from course where course_num=%s"
            if cur.execute(query, [num]):
                QMessageBox.warning(self, "插入异常", "该课程号已存在，请重新输入")
            elif not cur.execute("select * from teacher where teacher_num=%s", [t_num]):
                QMessageBox.warning(self, "插入异常", "该教师号在教师表中不存在，请尝试在教师表中插入对应条目")
            else:
                QMessageBox.information(self, "成功", "成功插入一条课程数据")
                query = "insert into course(course_num, course_name, teacher_num) values (%s,%s,%s)"
                cur.execute(query, [num, name, t_num])
                con.commit()  # 修改数据时，需要commit操作
                # TODO self.update_c_num_combobox()

    def course_delete(self):  # 删除课程信息
        num = self.course_num.text()
        if not num:
            QMessageBox.warning(self, "警告", "课程号为空")
        elif not num.isdigit() or len(num) != 3:
            QMessageBox.warning(self, "警告", "课程号只可为3位数字")
        else:
            query = "select * from course where course_num=%s"
            if not cur.execute(query, [num]):
                QMessageBox.warning(self, "删除异常", "该课程号不存在，请重新输入")
            elif cur.execute("select * from score where course_num=%s", [num]):
                QMessageBox.warning(self, "删除异常", "该课程号正被选课表作为外键引用，请尝试删除对应条目")
            else:
                if cur.execute("select * from score where course_num=%s", [num]):
                    QMessageBox.information(
                        self, "提示", "该课程号正被选课表作为外键引用，触发器已默认删除对应条目数据"
                    )
                QMessageBox.information(self, "成功", "成功删除一条课程数据")
                query = "delete from course where course_num=%s"
                cur.execute(query, [num])
                con.commit()  # 修改数据时，需要commit操作
                # TODO self.update_c_num_combobox()

    def score_insert(self):  # 新建分数信息
        s_num, c_num, grade = (
            self.score_student_num.text(),
            self.score_course_num.text(),
            self.score_grade.text(),
        )
        if not s_num or not c_num:
            QMessageBox.warning(self, "警告", "请输入学号课程号")
        elif (
            not s_num.isdigit()
            or len(s_num) != 10
            or not c_num.isdigit()
            or len(c_num) != 3
        ):
            QMessageBox.warning(self, "警告", "学号为10为数字，课程号为3位数字")
        else:
            query = "select * from score where student_num=%s and course_num=%s"
            # TODO trigger_on = mygui.add_trigger.isChecked()  # 触发器是否打开
            has_s_num, has_c_num = cur.execute(
                "select * from student where student_num=%s", [s_num]
            ), cur.execute(
                "select * from course where course_num=%s", [c_num]
            )  # 学号信息是否存在，班号信息是否存在
            if cur.execute(query, [s_num, c_num]):
                QMessageBox.warning(self, "插入异常", "该选课信息已存在，请重新输入")
            elif not has_s_num:
                QMessageBox.warning(self, "插入异常", "该学号在学生表中不存在，请尝试在学生表中插入对应条目")
            elif not has_c_num:
                QMessageBox.warning(self, "插入异常", "该课程号在课程表中不存在，请尝试在课程表中插入对应条目")
            else:
                if not has_s_num:
                    QMessageBox.information(self, "提示", "该学号在课程表中不存在，触发器已默认添加对应条目数据")
                if not has_c_num:
                    QMessageBox.information(self, "提示", "该课程号在课程表中不存在，触发器已默认添加对应条目数据")
                QMessageBox.information(self, "成功", "成功插入一条学生数据")
                query = (
                    "insert into score(student_num,course_num,grade) values (%s,%s,%s)"
                )
                cur.execute(query, [s_num, c_num, grade])
                con.commit()  # 修改数据时，需要commit操作
                self.update_s_name_combobox()
                # self.update_c_num_combobox()

    def score_delete(self):  # 删除分数信息
        s_num, c_num = self.score_student_num.text(), self.score_course_num.text()
        if not s_num or not c_num:
            QMessageBox.warning(self, "警告", "请输入学号课程号")
        elif (
            not s_num.isdigit()
            or len(s_num) != 10
            or not c_num.isdigit()
            or len(c_num) != 3
        ):
            QMessageBox.warning(self, "警告", "学号为10为数字，课程号为3位数字")
        else:
            query = "select * from score where student_num=%s and course_num=%s"
            if not cur.execute(query, [s_num, c_num]):
                QMessageBox.warning(self, "删除异常", "该选课信息不存在，请重新输入")
            else:
                QMessageBox.information(self, "成功", "成功删除一条选课信息")
                query = "delete from score where student_num=%s and course_num=%s"
                cur.execute(query, [s_num, c_num])
                con.commit()  # 修改数据时，需要commit操作
                self.update_s_name_combobox()
                # self.update_c_num_combobox()


if __name__ == "__main__":
    con = pymysql.connect(
        host="localhost",
        port=3306,
        user="root",
        password="lzf020420",
        database="university",
    )  # 连接数据库
    cur = con.cursor()  # 执行sql语句的游标
    app = QApplication(sys.argv)
    mainwindow = MainWindow()
    #update_s_name_combobox() 方法用于更新主窗口中的下拉列表框，显示可选的学生名称
    mainwindow.update_s_name_combobox()  
    #这是 PyQT5 应用程序的主循环，处理用户输入和事件，并在退出应用程序时返回一个整数值
    #其中 sys.exit() 方法可确保在主窗口被关闭后正常退出应用程序。
    mainwindow.show()
    sys.exit(app.exec_())
